import 'package:sqflite/sqflite.dart';

import 'package:diary_app/repositories/diary_repository.dart';
import 'package:diary_app/repositories/page_repository.dart';

class Options {

  Options._();

  static const String name = 'DiaryApp';
  static const int version = 1;

  static OnDatabaseConfigureFn onConfigure = (Database db) async {

    final Batch batch = db.batch();

    batch.execute('''
      PRAGMA foreign_keys = "ON"
    ''');

    await batch.commit();

  };

  static OnDatabaseCreateFn onCreate = (Database db, int version) async {

    final Batch batch = db.batch();

    batch.execute('''
      DROP TABLE IF EXISTS ${DiaryRepository.name}
    ''');

    batch.execute('''
      CREATE TABLE ${DiaryRepository.name} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    batch.execute('''
      DROP TABLE IF EXISTS ${PageRepository.name}
    ''');

    batch.execute('''
      CREATE TABLE ${PageRepository.name} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        diaryId INTEGER NOT NULL,
        FOREIGN KEY (diaryId) REFERENCES ${PageRepository.name} (id) ON UPDATE CASCADE ON DELETE CASCADE
      )
    ''');

    await batch.commit();

  };

  static OnDatabaseVersionChangeFn onUpgrade = (Database db, int oldVersion, int newVersion) async {};

  static OnDatabaseVersionChangeFn onDowngrade = (Database db, int oldVersion, int newVersion) async {};

}