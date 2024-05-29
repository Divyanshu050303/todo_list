import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/constant/constant.dart';
import 'package:todo_list/feature/add_task.dart/services/add_task.dart';
import 'package:todo_list/feature/auth/services/auth.dart';
import 'package:todo_list/feature/home/widget/task.dart';

class PenbdingTask extends StatefulWidget {
  final Function(bool, String, String, String, String)? showOption;
  const PenbdingTask({super.key, this.showOption});

  @override
  State<PenbdingTask> createState() => _PenbdingTaskState();
}

class _PenbdingTaskState extends State<PenbdingTask> {
  Authentication auth = Authentication();
  AddTaskServices addTaskServices = AddTaskServices();
  bool _isVisible = false;
  String taskId = "";
  String title1 = "";
  String description1 = "";
  String deadLine1 = "";
  String expectedDate1 = "";

  void toggleContainer(String? id) {
    setState(() {
      _isVisible = !_isVisible;
      taskId = id ?? "";
    });
  }

  void updateTask(
      String title, String description, String deadLine, String expectedDate) {
    setState(() {
      title1 = title;
      description1 = description;
      deadLine1 = deadLine;
      expectedDate1 = expectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    AddTaskServices taskServices = AddTaskServices();
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedOpacity(
            curve: Curves.easeInOut,
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    addTaskServices.deleteTask(taskId);
                  },
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: constant.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 24,
                      ))),
                ),
                GestureDetector(
                  onTap: () {
                    List<String> task = [];
                    task.add(taskId);
                    task.add(title1);
                    task.add(description1);
                    task.add(deadLine1);
                    task.add(expectedDate1);
                    print(task);
                    context.push("/editTask", extra: task);
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: constant.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ))),
                ),
                GestureDetector(
                  onTap: () {
                    auth.logout(context);
                  },
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: constant.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 24,
                      ))),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              toggleContainer("");
            },
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: constant.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                    child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 24,
                ))),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              context.push('/addTask');
            },
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: constant.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                    child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ))),
          )
        ],
      ),
      body: SizedBox(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height * 0.85,
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: taskServices.fetchTask("pending_task"),
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
                return GestureDetector(
                  onLongPress: () {
                    updateTask(
                        tasks[index]['title'],
                        tasks[index]['description'],
                        tasks[index]['deadLine'],
                        tasks[index]['expectedDate']);
                    toggleContainer(tasks[index]["id"]);
                  },
                  child: TaskTile(
                      id: tasks[index]["id"],
                      title: tasks[index]['title'],
                      description: tasks[index]['description'],
                      deadLine: tasks[index]['deadLine'],
                      expectedDate: tasks[index]['expectedDate']),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
