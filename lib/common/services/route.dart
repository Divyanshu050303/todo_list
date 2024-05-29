import 'package:go_router/go_router.dart';
import 'package:todo_list/feature/add_task.dart/screen/add_task.dart';
import 'package:todo_list/feature/auth/screen/auth.dart';
import 'package:todo_list/feature/edit_task/edit_task.dart';
import 'package:todo_list/feature/home/screen/home.dart';

class Routes {
  late String log;
  Routes({required this.log}) {
    routes = GoRouter(
        initialLocation: log == "loggedIn" ? "/home" : "/auth",
        routes: [
          GoRoute(
              path: "/auth", builder: (context, state) => const AuthScreen()),
          GoRoute(path: "/home", builder: (context, state) => const HomePage()),
          GoRoute(
              path: "/addTask",
              builder: (context, state) => const AddTaskPage()),
          GoRoute(
              path: "/editTask",
              builder: (context, state) {
                final taskDetails = state.extra as List<String>;
                return EditTaskPage(
                  taskDeatils: taskDetails,
                );
              }),
        ]);
  }
  static late final GoRouter routes;
}
