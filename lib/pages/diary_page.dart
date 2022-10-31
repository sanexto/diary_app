import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:diary_app/db/db.dart';

import 'package:diary_app/models/diary.dart' as model;
import 'package:diary_app/models/page.dart' as model;

import 'package:diary_app/repositories/page_repository.dart';

import 'package:diary_app/pages/edit_page.dart';

class DiaryPage extends StatefulWidget {

  final DB db;
  final model.Diary diary;

  const DiaryPage({ Key? key, required this.db, required this.diary }) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();

}

class _DiaryPageState extends State<DiaryPage> {

  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary.title),
      ),
      body: SafeArea(
        child: FutureBuilder<List<model.Page>>(
          future: PageRepository(widget.db).get(
            where: 'diaryId = ?',
            whereArgs: [ widget.diary.id ],
            orderBy: 'date DESC',
          ),
          initialData: const <model.Page>[],
          builder: (BuildContext context, AsyncSnapshot<List<model.Page>> snapshot) {

            Widget widget = const Center(
              child: CircularProgressIndicator(),
            );

            if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

              final List<model.Page> pages = snapshot.data!;

              widget = ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: pages.length,
                itemBuilder: (BuildContext context, int index) {

                  final model.Page page = pages[index];

                  return Dismissible(
                    key: ValueKey<model.Page>(page),
                    child: Card(
                      child: InkWell(
                        onTap: () => _edit(context, page),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                page.title,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(page.date),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (DismissDirection direction) => _delete(page.id!),
                  );

                },
              );

            }

            return widget;

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _add(context),
        backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).textTheme.button!.color,
        ),
      ),
    );

  }

  Future<void> _add(BuildContext context) async {

    final model.Page? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditPage(
          db: widget.db,
          diary: widget.diary,
        ),
      ),
    );

    if (result != null) {

      setState(() {});

    }

  }

  Future<void> _edit(BuildContext context, model.Page page) async {

    final model.Page? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditPage(
          db: widget.db,
          diary: widget.diary,
          page: page,
        ),
      ),
    );

    if (result != null) {

      setState(() {});

    }

  }

  Future<void> _delete(int id) async {

    await PageRepository(widget.db).delete(id);

    setState(() {});

  }

}