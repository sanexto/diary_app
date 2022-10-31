class Page {

  int? id;
  DateTime date;
  String title;
  String content;
  int diaryId;

  Page({ this.id, required this.date, required this.title, required this.content, required this.diaryId });

  Page.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        date = DateTime.fromMillisecondsSinceEpoch(map['date']),
        title = map['title'],
        content = map['content'],
        diaryId = map['diaryId'];

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'content': content,
      'diaryId': diaryId,
    };

  }

}