import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:diary_app/db/options.dart';

class DB {

  Future<String> get path async {

    return join(await getDatabasesPath(), '${Options.name}.db');

  }

  Future<List<Map<String, Object?>>> get(
      String table,
      {
        bool? distinct,
        List<String>? columns,
        String? where,
        List<Object?>? whereArgs,
        String? groupBy,
        String? having,
        String? orderBy,
        int? limit,
        int? offset,
      }
  ) async {

    final Database db = await _open();

    final List<Map<String, Object?>> result = await db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );

    db.close();

    return result;

  }

  Future<int> insert(String table, Map<String, Object?> values) async {

    final Database db = await _open();

    final int result = await db.insert(table, values);

    db.close();

    return result;

  }

  Future<int> update(String table, Map<String, Object?> values, { String? where, List<Object?>? whereArgs }) async {

    final Database db = await _open();

    final int result = await db.update(table, values, where: where, whereArgs: whereArgs);

    db.close();

    return result;

  }

  Future<int> delete(String table, { String? where, List<Object?>? whereArgs }) async {

    final Database db = await _open();

    final int result = await db.delete(table, where: where, whereArgs: whereArgs);

    db.close();

    return result;

  }

  Future<Database> _open() async {

    return await openDatabase(
      await path,
      version: Options.version,
      onConfigure: Options.onConfigure,
      onCreate: Options.onCreate,
      onUpgrade: Options.onUpgrade,
      onDowngrade: Options.onDowngrade,
    );

  }

}