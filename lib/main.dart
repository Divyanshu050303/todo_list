import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/common/services/route.dart';
import 'package:todo_list/common/services/shared_preference.dart';
import 'package:todo_list/constant/constant.dart';
import 'package:todo_list/feature/home/services/bool_provider.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (kIsWeb) {
  app = await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCUQQEr_dQQqg_nQz4PTRhnp1IFHP62UDY",
          authDomain: "todo-list-787cd.firebaseapp.com",
          projectId: "todo-list-787cd",
          storageBucket: "todo-list-787cd.appspot.com",
          messagingSenderId: "56500871529",
          appId: "1:56500871529:web:bf6aaecba5a88e38349df8"));
  // } else {
  //   app = await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  // }
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
  );
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: constant.primary,
      systemNavigationBarColor: const Color.fromARGB(0, 255, 255, 255),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<String>(
        future: customSharePreference().readData('logIn'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading preferences'));
          } else {
            final log = snapshot.data ?? '';
            return MyAppWithRouter(logInfo: log);
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppWithRouter extends StatelessWidget {
  final String logInfo;
  MyAppWithRouter({super.key, required this.logInfo});

  @override
  Widget build(BuildContext context) {
    Routes(log: logInfo);
    return MaterialApp.router(
      routerConfig: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
