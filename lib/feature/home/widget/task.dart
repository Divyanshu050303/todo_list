import 'package:flutter/material.dart';
import 'package:todo_list/common/custom_button.dart';
import 'package:todo_list/feature/add_task.dart/services/add_task.dart';

class TaskTile extends StatefulWidget {
  final String? id;
  final String? title;
  final String? description;
  final String? deadLine;
  final String? expectedDate;
  final bool? isComplete;

  const TaskTile(
      {super.key,
      this.id,
      this.title,
      this.deadLine,
      this.expectedDate,
      this.isComplete,
      this.description});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  IconData _icon = Icons.keyboard_arrow_down_rounded;
  AddTaskServices addTaskServices = AddTaskServices();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      width: mediaQueryData.size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? "",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.deadLine ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                _icon = _isExpanded
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_rounded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  _icon,
                  size: 28,
                )
              ],
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            child: Visibility(
              visible: _isExpanded,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text(widget.expectedDate ?? "")],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(widget.description ?? ""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.isComplete ?? false
                          ? SizedBox()
                          : CustomButton(
                              size: const Size(120, 35),
                              text: "Complete",
                              onTap: () {
                                addTaskServices.completedTask(
                                    widget.title ?? "",
                                    widget.description ?? "",
                                    widget.deadLine ?? "",
                                    widget.expectedDate ?? "");
                                addTaskServices.deleteTask(widget.id ?? "");
                              })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
