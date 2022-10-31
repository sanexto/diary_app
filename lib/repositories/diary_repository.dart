import 'package:diary_app/db/db.dart';

import 'package:diary_app/models/diary.dart';

class DiaryRepository {

  static const String name = 'Diary';

  final DB _db;

  const DiaryRepository(this._db);

  Future<List<Diary>> get({
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {

    return (await _db.get(
      name,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    )).map<Diary>((Map<String, Object?> e) => Diary.fromMap(e)).toList();

  }

  Future<int> insert(Diary diary) async {

    return await _db.insert(name, diary.toMap());

  }

  Future<int> update(Diary diary) async {

    return await _db.update(name, diary.toMap(), where: 'id = ?', whereArgs: [ diary.id ]);

  }

  Future<int> delete(int id) async {

    return await _db.delete(name, where: 'id = ?', whereArgs: [ id ]);

  }

}