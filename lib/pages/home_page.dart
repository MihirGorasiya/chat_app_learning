// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:roadmap_learning/pages/calls_page.dart';
import 'package:roadmap_learning/pages/camera_page.dart';
import 'package:roadmap_learning/pages/chat_page.dart';
import 'package:roadmap_learning/pages/status_page.dart';
import 'package:roadmap_learning/widgets/tab_text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Roadmap Learning"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: TabText(tabText: "Chats"),
              ),
              Tab(
                child: TabText(tabText: "Status"),
              ),
              Tab(
                child: TabText(tabText: "Calls"),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                _selectedIndex = 2;
                setState(() {});
              },
              child: SizedBox(
                width: 50,
                child: Icon(
                  Icons.more_vert,
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(children: [
          CameraPage(
            camera: widget.camera,
          ),
          ChatPage(),
          StatusPage(),
          CallsPage(),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: "BUsiness",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_rounded),
              label: "Office",
            ),
          ],
        ),
      ),
    );
  }
}
