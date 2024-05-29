import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/common/custom_button.dart';
import 'package:todo_list/common/custom_textfield.dart';
import 'package:todo_list/constant/constant.dart';
import 'package:todo_list/feature/add_task.dart/services/add_task.dart';

class EditTaskPage extends StatefulWidget {
  final List<String>? taskDeatils;
  const EditTaskPage({super.key, this.taskDeatils});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  AddTaskServices addTask = AddTaskServices();
  String id = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController expetedtimeController = TextEditingController();
  Future<void> _selectTime(BuildContext context, String type) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Set the initial time to the current time
    );

    if (selectedTime != null) {
      setState(() {
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (type == "Dead") {
          deadlineController.text =
              DateFormat('HH:mm').format(selectedDateTime);
        } else if (type == "except") {
          expetedtimeController.text =
              DateFormat('HH:mm').format(selectedDateTime);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.taskDeatils![0];
    print(id);
    titleController.text = widget.taskDeatils![1];
    descriptionController.text = widget.taskDeatils![2];
    deadlineController.text = widget.taskDeatils![3];
    expetedtimeController.text = widget.taskDeatils![4];
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: mediaQueryData.size.height * .05, left: 20),
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height * 0.15,
            decoration: BoxDecoration(
                color: constant.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.pop("/home");
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                const SizedBox(width: 10),
                const Text(
                  "Good to see you",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaQueryData.size.height * 0.12,
          ),
          CustomTextField(controller: titleController, hintText: "Title"),
          SizedBox(
            height: mediaQueryData.size.height * 0.02,
          ),
          CustomTextField(
            controller: deadlineController,
            hintText: "Dead Line",
            onSelectDate: _selectTime,
          ),
          SizedBox(
            height: mediaQueryData.size.height * 0.02,
          ),
          CustomTextField(
            controller: expetedtimeController,
            hintText: "Expected time to complete task",
            onSelectDate: _selectTime,
          ),
          SizedBox(
            height: mediaQueryData.size.height * 0.02,
          ),
          CustomTextField(
            controller: descriptionController,
            hintText: "Discription",
            maxLines: 5,
          ),
          SizedBox(
            height: mediaQueryData.size.height * 0.02,
          ),
          CustomButton(
              text: "Add task",
              onTap: () {
                addTask.updateTask(
                    id,
                    titleController.text,
                    descriptionController.text,
                    deadlineController.text,
                    expetedtimeController.text,
                    context);
                titleController.clear();
                descriptionController.clear();
                deadlineController.clear();
                expetedtimeController.clear();
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task Updated successful')));
              })
        ],
      ),
    ));
  }
}
