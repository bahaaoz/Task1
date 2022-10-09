import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/Model/dataController.dart';
import 'package:task1/Screens/listPage.dart';

import 'Screens/addPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataController(),
      child: MaterialApp(
        initialRoute: "list",
        routes: {
          "list": (context) => ListPage(),
          "add": (context) => AddPage(),
        },
        debugShowCheckedModeBanner: false,
        home: Scaffold(),
      ),
    );
  }
}
