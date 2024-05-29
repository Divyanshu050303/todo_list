import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/common/custom_button.dart';
import 'package:todo_list/common/custom_textfield.dart';
import 'package:todo_list/constant/constant.dart';
import 'package:todo_list/feature/add_task.dart/services/add_task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  AddTaskServices addTask = AddTaskServices();

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
            child: const Text(
              "Good to see you",
              style: TextStyle(color: Colors.white, fontSize: 22),
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
                addTask.addTask(
                    titleController.text,
                    descriptionController.text,
                    deadlineController.text,
                    expetedtimeController.text);
                titleController.clear();
                descriptionController.clear();
                deadlineController.clear();
                expetedtimeController.clear();
              })
        ],
      ),
    ));
  }
}
