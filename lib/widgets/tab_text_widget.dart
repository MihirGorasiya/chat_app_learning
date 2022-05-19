// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TabText extends StatelessWidget {
  const TabText({
    Key? key,
    required this.tabText,
  }) : super(key: key);
  final String tabText;
  @override
  Widget build(BuildContext context) {
    return Text(
      tabText,
      style: TextStyle(color: Colors.black),
    );
  }
}
