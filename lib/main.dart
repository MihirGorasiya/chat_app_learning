// ignore_for_file: prefer_const_constructors, must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:roadmap_learning/pages/home_page.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MyApp(
      firstCamera: firstCamera,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.firstCamera}) : super(key: key);
  CameraDescription firstCamera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roadmap Learning",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      themeMode: ThemeMode.light,
      home: HomePage(
        camera: firstCamera,
      ),
    );
  }
}
