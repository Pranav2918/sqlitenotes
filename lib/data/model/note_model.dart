class NoteModel {
  final int? id;
  final String title;
  final String createdAt;

  NoteModel({this.id, required this.title, required this.createdAt});

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        createdAt = res["createdAt"];

  Map<String, Object?> toMap() {
    return {"id": id, "title": title, "createdAt": createdAt};
  }
}
