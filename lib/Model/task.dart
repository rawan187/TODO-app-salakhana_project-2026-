class Task {

  String title;
  String? description;
  String? deadline;
  bool isDone;
  //for future feature
  //DateTime createdAt;

  Task({
    required this.title,
    this.description,
    this.deadline,
    this.isDone = false,
    //DateTime? createdAt,
  }); //: createdAt = createdAt ?? DateTime.now();

}