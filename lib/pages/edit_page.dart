import 'package:flutter/material.dart';

import 'package:diary_app/db/db.dart';

import 'package:diary_app/models/diary.dart' as model;
import 'package:diary_app/models/page.dart' as model;

import 'package:diary_app/repositories/page_repository.dart';

class EditPage extends StatefulWidget {

  final DB db;
  final model.Diary diary;
  final model.Page? page;

  const EditPage({ Key? key, required this.db, required this.diary, this.page }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();

}

class _EditPageState extends State<EditPage> {

  final TextEditingController _ctrlTitle = TextEditingController();
  final TextEditingController _ctrlContent = TextEditingController();

  @override
  void initState() {

    super.initState();

    final model.Page? page = widget.page;

    if (page != null) {

      _ctrlTitle.text = page.title;
      _ctrlContent.text = page.content;

    }

  }

  @override
  void dispose() {

    _ctrlContent.dispose();
    _ctrlTitle.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final model.Page? page = widget.page;

    return Scaffold(
      appBar: AppBar(
        title: page != null ? const Text('Edit page') : const Text('New page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ctrlTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: _ctrlContent,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Content',
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.newline,
                maxLines: 8,
                minLines: 8,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () => _save(context),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Future<void> _save(BuildContext context) async {

    int result = 0;
    model.Page? page = widget.page;

    if (page != null) {

      page.date = DateTime.now();
      page.title = _ctrlTitle.text;
      page.content = _ctrlContent.text;

      result = await PageRepository(widget.db).update(page);

    } else {

      page = model.Page(
        date: DateTime.now(),
        title: _ctrlTitle.text,
        content: _ctrlContent.text,
        diaryId: widget.diary.id!,
      );

      result = await PageRepository(widget.db).insert(page);

      if (result > 0) {

        page.id = result;

      }

    }

    if (result > 0 && mounted) {

      Navigator.pop(context, page);

    }

  }

}