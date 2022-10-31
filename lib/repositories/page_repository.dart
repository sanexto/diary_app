import 'package:diary_app/db/db.dart';

import 'package:diary_app/models/page.dart';

class PageRepository {

  static const String name = 'Page';

  final DB _db;

  const PageRepository(this._db);

  Future<List<Page>> get({
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
    )).map<Page>((Map<String, Object?> e) => Page.fromMap(e)).toList();

  }

  Future<int> insert(Page page) async {

    return await _db.insert(name, page.toMap());

  }

  Future<int> update(Page page) async {

    return await _db.update(name, page.toMap(), where: 'id = ?', whereArgs: [ page.id ]);

  }

  Future<int> delete(int id) async {

    return await _db.delete(name, where: 'id = ?', whereArgs: [ id ]);

  }

}