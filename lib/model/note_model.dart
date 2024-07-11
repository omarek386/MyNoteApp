// ignore_for_file: public_member_api_docs, sort_constructors_first

class Note {
  int? id;
  String? title;
  String? content;
  String? timeCreated;
  String? timeEdited;
  Note({
    this.id,
    this.title,
    this.content,
    this.timeCreated,
    this.timeEdited,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'timeCreated': timeCreated,
      'timeEdited': timeEdited,
    };
  }
}
