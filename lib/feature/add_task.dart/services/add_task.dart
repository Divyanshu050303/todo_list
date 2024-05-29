import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:todo_list/main.dart';

class AddTaskServices {
  DatabaseReference reference = FirebaseDatabase.instance.ref();
  void addTask(
      String title, String description, String deadline, String expectedDate) {
    if (title.isNotEmpty &&
        description.isNotEmpty &&
        deadline.isNotEmpty &&
        expectedDate.isNotEmpty) {
      reference
          .child("pending_task")
          .child(auth.currentUser?.uid ?? "")
          .push()
          .set({
        'title': title,
        'description': description,
        'deadLine': deadline,
        'expectedDate': expectedDate
      }).then((_) {
        print("message Send successfully");
      });
    }
  }

  void updateTask(String taskId, String title, String description,
      String deadline, String expectedDate, BuildContext context) {
    reference
        .child("pending_task")
        .child(auth.currentUser?.uid ?? "")
        .child(taskId)
        .set({
      'title': title,
      'description': description,
      'deadLine': deadline,
      'expectedDate': expectedDate
    }).then((value) {});
  }

  void deleteTask(String taskId) {
    reference
        .child("pending_task")
        .child(auth.currentUser?.uid ?? "")
        .child(taskId)
        .remove()
        .then((_) {
      print("Task deleted successfully");
    }).catchError((error) {
      print("Failed to delete task: $error");
    });
  }

  Stream<List<Map<String, dynamic>>> fetchTask(String taskStatus) {
    return reference
        .child(taskStatus)
        .child(auth.currentUser?.uid ?? "")
        .onValue
        .map((event) {
      List<Map<String, dynamic>> tasks = [];
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((key, value) {
          tasks.add({
            'id': key,
            'title': value['title'] ?? '',
            'description': value['description'] ?? '',
            'deadLine': value['deadLine'] ?? '',
            'expectedDate': value['expectedDate'] ?? '',
          });
        });
      }
      return tasks;
    });
  }

  void completedTask(String title, String description, String deadLine,
      String expectedDate) async {
    if (title.isNotEmpty &&
        description.isNotEmpty &&
        deadLine.isNotEmpty &&
        expectedDate.isNotEmpty) {
      reference
          .child("complete_task")
          .child(auth.currentUser?.uid ?? "")
          .push()
          .set({
        'title': title,
        'description': description,
        'deadLine': deadLine,
        'expectedDate': expectedDate
      }).then((_) {
        print("message Send successfully");
      });
    }
  }
}
