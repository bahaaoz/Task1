import 'package:flutter/material.dart';
import 'package:task1/Screens/EditAddForm.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: formEditAdd(todo: null),
    );
  }
}
