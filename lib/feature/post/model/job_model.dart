import 'package:timeago/timeago.dart' as timeago;

class JobModel {
  int? id;
  String email;
  String title;
  String about;
  String requirement;
  String salary;
  String userName;
  String img;
  DateTime? dateTime;

  JobModel({
    this.id,
    this.dateTime,
    required this.userName,
    required this.img,
    required this.email,
    required this.title,
    required this.about,
    required this.requirement,
    required this.salary
  });

  // Factory constructor to create a Product from a map (from JSON)
  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'],
      dateTime: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      userName: map['user_name'],
      img: map['img'],
      email: map['email'],
      title: map['title'],
      about: map['about'],
      requirement: map['requirement'],
      salary: map['salary']
    );
  }

  // Convert Product object to map (for sending to a server)
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'email': email,
      'title': title,
      'about': about,
      'requirement': requirement,
      'salary': salary,
      'img': img,
      'user_name': userName
    };
  }

  // Method to get the formatted time
  String getFormattedDateTime() {
    if (dateTime == null) {
      return 'No date provided';
    }
    return timeago.format(dateTime!);
  }
}
