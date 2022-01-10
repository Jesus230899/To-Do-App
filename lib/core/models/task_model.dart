class TaskModel {
  TaskModel({
    this.id,
    this.title,
    this.isCompleted,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
  });

  int id;
  String title;
  bool isCompleted;
  String dueDate;
  String comments;
  String description;
  String tags;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json["title"] ?? '',
        isCompleted: json["is_completed"] ?? true,
        dueDate: json["due_date"],
        comments: json["comments"] ?? '',
        description: json["description"] ?? '',
        tags: json["tags"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "is_completed": isCompleted,
        "due_date": dueDate,
        "comments": comments,
        "description": description,
        "tags": tags,
      };
}
