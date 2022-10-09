import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task1/colors.dart';

import '../Model/TODO.dart';
import '../Model/dataController.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //_______________SEARCH________________
  String searchStr = "";
  TextEditingController serchController = TextEditingController();

  Timer? depounce;
//___________________________

//__________ADD_____________________
//_____________________________________
  DateTime datePick = DateTime.now();
  String nameTODOStr = "";
  String descriptionStr = "";
  String datePickStr = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
//______________________________________________

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: const Text("TODO App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        child: const Icon(Icons.note_add_rounded),
        onPressed: () {
          nameController.clear();
          descriptionController.clear();
          datePickStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return dialogSheet("ADD", null);
            },
          );
        },
      ),
      body: Consumer<DataController>(
        builder: (context, dataConroller, child) {
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 100,
                        child: TextField(
                          controller: serchController,
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.search),
                              suffix: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  serchController.clear();
                                  if (depounce?.isActive ?? false) {
                                    depounce?.cancel();
                                  }

                                  depounce = Timer(
                                      const Duration(milliseconds: 500), () {
                                    setState(() {
                                      searchStr = "";
                                    });
                                  });
                                },
                              )),
                          onChanged: (value) {
                            if (depounce?.isActive ?? false) depounce?.cancel();
                            depounce = Timer(const Duration(seconds: 1), () {
                              if (searchStr != serchController.text) {
                                setState(() {
                                  searchStr = value.trim();
                                });
                              }
                            });
                          },
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          "data",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 13,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 210,
                    crossAxisCount:
                        (MediaQuery.of(context).size.width < 600) ? 1 : 2,
                  ),
                  itemCount: dataConroller.listSize,
                  itemBuilder: (context, index) {
                    print(MediaQuery.of(context).size.width);
                    TODO todo = dataConroller.list[index];
                    if (todo.name
                            .toLowerCase()
                            .contains(searchStr.toLowerCase()) ||
                        todo.description
                            .toLowerCase()
                            .contains(searchStr.toLowerCase())) {
                      return card(todo, dataConroller);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container dialogSheet(String from, TODO? todo) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(247, 255, 255, 255),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          Text(
            "${from} TODO",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(179, 0, 0, 0), width: 1))),
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              //اذا بعمله ليست فيو بضرب

              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 2,
                  minLines: 1,
                  decoration: const InputDecoration(
                    counterStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
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
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightBlue,
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            )),
                        child: MaterialButton(
                          hoverColor: Colors.black38,
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
                          child: const Text(
                            "Due Date",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        datePickStr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Consumer<DataController>(
                  builder: (context, dataController, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: blue,
                                border: Border.all(width: 1, color: darkBlue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: MaterialButton(
                              onPressed: () {
                                if (from == "ADD") {
                                  TODO newTodo = TODO(
                                    nameTODOStr.trim(),
                                    descriptionStr.trim(),
                                    datePickStr,
                                    DateTime.now(),
                                  );

                                  dataController.addTODO(newTodo);

                                  setState(() {
                                    nameController.clear();
                                    descriptionController.clear();
                                    datePick = DateTime.now();
                                  });
                                } else {
                                  setState(() {
                                    todo?.name = nameController.text.trim();
                                    todo?.description =
                                        descriptionController.text.trim();
                                    todo?.dateDue = datePickStr;
                                  });
                                }
                              },
                              child: Text(
                                from,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container card(TODO todo, DataController dataConroller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset.zero,
                    color: Color.fromARGB(169, 80, 150, 200),
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
                color: Color.fromARGB(255, 248, 248, 248)),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 221, 219, 219)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: const Color.fromARGB(255, 230, 229, 229)),
                        child: Text(
                          todo.name.length > 15
                              ? "${todo.name..substring(0, 15)}..."
                              : todo.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        margin: const EdgeInsets.symmetric(
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 213, 211, 211)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 220, 218, 218)),
                        child: Text(
                          "Description : \n${todo.description.length > 60 ? "${todo.description.substring(0, 60)}..." : todo.description}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.yellow,
                        ),
                        child: Text(
                          "Date : ${todo.dateDue}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          dataConroller.rempveTODO(todo);
                        },
                        icon: const Icon(
                          color: Colors.red,
                          Icons.delete,
                        ),
                      ),
                      Switch(
                        value: todo.valueToggle,
                        onChanged: (value) {
                          dataConroller.changToggle(todo);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 60,
                height: 25,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: MaterialButton(
                  onPressed: () {
                    nameController.text = todo.name;
                    descriptionController.text = todo.description;
                    datePickStr = todo.dateDue;
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return dialogSheet("Edit", todo);
                      },
                    );
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
