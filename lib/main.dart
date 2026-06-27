import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ostad_live_test/screens/add_student.dart';
import 'package:ostad_live_test/screens/home.dart';
// Import the generated file
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}