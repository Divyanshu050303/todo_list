import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_list/constant/constant.dart';
import 'package:todo_list/feature/add_task.dart/services/add_task.dart';
import 'package:todo_list/feature/home/screen/complete.dart';
import 'package:todo_list/feature/home/screen/pending.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool show = false;

  AddTaskServices taskServices = AddTaskServices();
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: mediaQueryData.size.height * .05, left: 20),
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height * 0.16,
            decoration: BoxDecoration(
                color: constant.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: SizedBox(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height * 0.16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good to see you",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(
                    width: mediaQueryData.size.width * 0.35,
                  ),
                  const TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: "Pending Task",
                      ),
                      Tab(
                        text: "Completed Task",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height * 0.84,
            child: const TabBarView(
              children: [PenbdingTask(), CompletedTask()],
            ),
          ),
        ],
      )),
    );
  }
}
