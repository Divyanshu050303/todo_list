import 'package:flutter/material.dart';
import 'package:todo_list/feature/add_task.dart/services/add_task.dart';
import 'package:todo_list/feature/home/widget/task.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    AddTaskServices taskServices = AddTaskServices();
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height * 0.85,
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: taskServices.fetchTask("complete_task"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Map<String, dynamic>> tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                  isComplete: true,
                  id: tasks[index]["id"],
                  title: tasks[index]['title'],
                  description: tasks[index]['description'],
                  deadLine: tasks[index]['deadLine'],
                  expectedDate: tasks[index]['expectedDate']);
            },
          );
        },
      ),
    );
  }
}
