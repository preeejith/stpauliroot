class StaffHomeworkModal {
  String? subjectName;
  String? topicName;
  String? lastSubDate;
  String? className;
  String? students;
  int? completed;

  StaffHomeworkModal({
    this.subjectName,
    this.topicName,
    this.lastSubDate,
    this.className,
    this.students,
    this.completed,
  });

  factory StaffHomeworkModal.fromJson(Map<String, dynamic> json) {
    return StaffHomeworkModal(
      subjectName: json['subjectName'],
      topicName: json['topicName'],
      lastSubDate: json['lastSubDate'],
      className: json['className'],
      students: json['students'],
      completed: json['completed'],
    );
  }
}
