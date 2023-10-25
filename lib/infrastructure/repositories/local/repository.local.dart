import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalRepository {
  factory LocalRepository.instance() => _instance;

  LocalRepository._() {
    Hive.initFlutter();
  }

  static final LocalRepository _instance = LocalRepository._();

  @protected
  String get _instanceName => 'LocalStorage';

  @protected
  bool get _isOpen => Hive.isBoxOpen(_instanceName);

  @protected
  Future<Box<M>> openDb<M>() async => _isOpen
      ? Hive.box<M>(_instanceName)
      : await Hive.openBox<M>(
          _instanceName,
          path:
              !kIsWeb ? (await getApplicationDocumentsDirectory()).path : null,
        );

  // Implementation

  Future<String?> readTheme() async {
    final Box<String> db = await openDb<String>();
    final user = db.get('theme');
    await db.close();
    return user;
  }

  Future<void> persistTheme(final ThemeData theme) async {
    final Box<String> db = await openDb<String>();
    await db.put(
      'theme',
      theme.brightness == Brightness.light ? 'light' : 'dark',
    );
    await db.close();
  }

  Future<void> clearTheme() async {
    final Box<String> db = await openDb<String>();
    await db.delete('Theme');
    await db.close();
  }
}
