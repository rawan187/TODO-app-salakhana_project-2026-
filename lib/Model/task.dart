class Task {

  String title;
  String? description;
  String? deadline;
  bool isDone;
  //for future feature (alert when deadline is near)
  //DateTime createdAt;

  bool isHabit;
  DateTime? lastCompletedDate;

  String userEmail;

  Task({
    required this.title,
    this.description,
    this.deadline,
    this.isDone = false,
    this.isHabit = false,
    this.lastCompletedDate,
    required this.userEmail,
    //DateTime? createdAt,
  }); //: createdAt = createdAt ?? DateTime.now();

}