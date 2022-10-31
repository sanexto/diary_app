import 'package:flutter/material.dart';

import 'package:diary_app/models/diary.dart' as model;

class UnlockForm extends StatelessWidget {

  final List<model.Diary> diaries;
  final model.Diary? diary;
  final ValueChanged<model.Diary?> onDiaryChanged;
  final TextEditingController ctrlPassword;
  final VoidCallback onNewPressed;
  final VoidCallback onUnlockPressed;

  const UnlockForm({
    Key? key,
    required this.diaries,
    this.diary,
    required this.onDiaryChanged,
    required this.ctrlPassword,
    required this.onNewPressed,
    required this.onUnlockPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<model.Diary>(
              items: diaries.map<DropdownMenuItem<model.Diary>>((model.Diary e) {

                return DropdownMenuItem<model.Diary>(
                  value: e,
                  child: Text(e.title),
                );

              }).toList(),
              value: diary,
              onChanged: onDiaryChanged,
              icon: const Icon(Icons.arrow_downward),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: ctrlPassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              obscureText: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: onNewPressed,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text('New'),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                ElevatedButton(
                  onPressed: onUnlockPressed,
                  child: const Text('Unlock'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

}