import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/colors.dart';

import '../Model/TODO.dart';
import '../Model/dataController.dart';
import 'EditAddForm.dart';

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

  final midwidth = 600;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return formEditAdd(
                todo: null,
              );
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
                                      searchStr = ""; //........
                                    });
                                    dataConroller.finalResultList("");
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
                                dataConroller.finalResultList(value.trim());
                              }
                            });
                          },
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          "test",
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
                        (MediaQuery.of(context).size.width < midwidth) ? 1 : 2,
                  ),
                  itemCount: dataConroller.listSize,
                  itemBuilder: (context, index) {
                    TODO todo = dataConroller.list[index];

                    return card(todo, dataConroller);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

//card
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return formEditAdd(
                                todo: todo,
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
