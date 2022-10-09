import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Model/TODO.dart';
import '../Model/dataController.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DateTime datePick = DateTime.now();
  String nameTODOStr = "";
  String descriptionStr = "";
  String datePickStr = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("list");
          },
          child: const Text("List TODO"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("add");
          },
          child: const Text("Add TODO"),
        )
      ]),
      appBar: AppBar(
        title: const Text("TODO App"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text(
                    "TODO Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                onChanged: (value) {
                  nameTODOStr = value;
                },
              ),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  label: Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                onChanged: (value) {
                  descriptionStr = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ).then((date) {
                        setState(() {
                          datePick = date!;
                          datePickStr =
                              DateFormat('yyyy-MM-dd').format(datePick);
                        });
                      });
                    },
                    child: const Text("Due Date"),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(datePick),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DataController>(
                builder: (context, dataController, child) {
                  return ElevatedButton(
                    onPressed: () {
                      TODO newTodo = TODO(
                        nameTODOStr,
                        descriptionStr,
                        datePickStr,
                        DateTime.now(),
                      );

                      dataController.addTODO(newTodo);

                      setState(() {
                        nameController.clear();
                        descriptionController.clear();
                        datePick = DateTime.now();
                      });
                    },
                    child: const Text("Add"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
