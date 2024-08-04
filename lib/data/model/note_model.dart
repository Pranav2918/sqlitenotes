class NoteModel {
  final int id;
  final String title;
  final String description;

  NoteModel({required this.id, required this.title, required this.description});

  // Constructor that creates a NoteModel from a Map
  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'];

  // Method to convert NoteModel object to a Map
  Map<String, Object> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}
