class Diary {

  int? id;
  String title;
  String password;

  Diary({ this.id, required this.title, required this.password });

  Diary.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        password = map['password'];

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'title': title,
      'password': password,
    };

  }

}