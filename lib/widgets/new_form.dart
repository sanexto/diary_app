import 'package:flutter/material.dart';

class NewForm extends StatelessWidget {

  final TextEditingController ctrlTitle;
  final TextEditingController ctrlPassword;
  final VoidCallback? onBackPressed;
  final VoidCallback onSavePressed;

  const NewForm({
    Key? key,
    required this.ctrlTitle,
    required this.ctrlPassword,
    this.onBackPressed,
    required this.onSavePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: ctrlTitle,
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
                if (onBackPressed != null) ...[
                  ElevatedButton(
                    onPressed: onBackPressed,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: const Text('Back'),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
                ElevatedButton(
                  onPressed: onSavePressed,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

}