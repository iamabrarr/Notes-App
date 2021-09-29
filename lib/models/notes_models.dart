class NotesModels {
  int? id;
  String title, description;
  NotesModels({this.id, required this.description, required this.title});
  factory NotesModels.fromMap(Map<String, dynamic> json) => NotesModels(
      id: json['id'], description: json['description'], title: json['title']);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
