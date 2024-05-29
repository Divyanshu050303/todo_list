import 'package:firebase_database/firebase_database.dart';

class Task {
  String? id;
  String title;
  String description;
  String deadLine;
  String expectedDate;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.deadLine,
      required this.expectedDate});

  Task.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        title = (snapshot.value as Map)['title'] ?? '',
        description = (snapshot.value as Map)['description'] ?? '',
        deadLine = (snapshot.value as Map)['deadLine'] ?? '',
        expectedDate = (snapshot.value as Map)['expectedDate'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'titll': title,
      'description': description,
      'deadLine': deadLine,
      'expectedDate': expectedDate
    };
  }
}
