import 'package:flutter/material.dart';

import 'package:diary_app/db/db.dart';

import 'package:diary_app/models/diary.dart' as model;

import 'package:diary_app/repositories/diary_repository.dart';

import 'package:diary_app/widgets/new_form.dart';
import 'package:diary_app/widgets/unlock_form.dart';

import 'package:diary_app/pages/diary_page.dart';

class HomePage extends StatefulWidget {

  final DB db;

  const HomePage({ Key? key, required this.db }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final TextEditingController _ctrlTitle = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  bool? _newForm;
  model.Diary? _dropdownValue;

  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {

    _ctrlPassword.dispose();
    _ctrlTitle.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final bool? newForm = _newForm;

    return Scaffold(
      body: SafeArea(
        child: newForm == null || !newForm ? FutureBuilder<List<model.Diary>>(
          future: DiaryRepository(widget.db).get(),
          initialData: const <model.Diary>[],
          builder: (BuildContext context, AsyncSnapshot<List<model.Diary>> snapshot) {

            Widget widget = const Center(
              child: CircularProgressIndicator(),
            );

            if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

              final List<model.Diary> diaries = snapshot.data!;

              if (diaries.isEmpty) {

                widget = NewForm(
                  ctrlTitle: _ctrlTitle,
                  ctrlPassword: _ctrlPassword,
                  onSavePressed: () => _save(context),
                );

              } else {

                _dropdownValue = diaries.first;

                widget = UnlockForm(
                  diaries: diaries,
                  diary: _dropdownValue,
                  onDiaryChanged: (model.Diary? value) => _dropdownValue = value,
                  ctrlPassword: _ctrlPassword,
                  onNewPressed: () {

                    _ctrlPassword.clear();

                    setState(() {

                      _newForm = true;

                    });

                  },
                  onUnlockPressed: () => _unlock(context),
                );

              }

            }

            return widget;

          },
        ) : NewForm(
          ctrlTitle: _ctrlTitle,
          ctrlPassword: _ctrlPassword,
          onBackPressed: () {

            _ctrlTitle.clear();
            _ctrlPassword.clear();

            setState(() {

              _newForm = false;

            });

          },
          onSavePressed: () => _save(context),
        ),
      ),
    );

  }

  Future<void> _save(BuildContext context) async {

    final model.Diary diary = model.Diary(
      title: _ctrlTitle.text,
      password: _ctrlPassword.text,
    );

    final int result = await DiaryRepository(widget.db).insert(diary);

    if (result > 0) {

      diary.id = result;

      if (mounted) {

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => DiaryPage(
              db: widget.db,
              diary: diary,
            ),
          ),
        );

        _ctrlTitle.clear();
        _ctrlPassword.clear();

        setState(() {

          _newForm = false;

        });

      }

    }

  }

  Future<void> _unlock(BuildContext context) async {

    final model.Diary dropdownValue = _dropdownValue!;

    final List<model.Diary> result = await DiaryRepository(widget.db).get(
      where: 'id = ? AND password = ?',
      whereArgs: [ dropdownValue.id, _ctrlPassword.text ],
    );

    if (result.isNotEmpty) {

      if (mounted) {

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => DiaryPage(
              db: widget.db,
              diary: result.first,
            ),
          ),
        );

        _ctrlPassword.clear();

      }

    }

  }

}