import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task1/Model/TODO.dart';

import '../Model/dataController.dart';
import '../colors.dart';

//if todo null then the method will add new todo
// //if todo not null the method will edit the todo
class formEditAdd extends StatefulWidget {
  final TODO? todo;

  formEditAdd({super.key, required this.todo});

  @override
  State<formEditAdd> createState() => _formEditAddState(todo: todo);
}

class _formEditAddState extends State<formEditAdd> {
//__________ADD_____________________
//_____________________________________
  DateTime datePick = DateTime.now();
  String nameTODOStr = "";
  String descriptionStr = "";
  String datePickStr = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
//______________________________________________

  TODO? todo;
  _formEditAddState({required this.todo});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (todo != null) {
      nameController.text = todo!.name;
      descriptionController.text = todo!.description;
      datePickStr = todo!.dateDue;
    }
  }

  @override
  Widget build(BuildContext context) {
    const midwidth = 600;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: const BoxDecoration(
          color: Color.fromARGB(247, 255, 255, 255),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${todo == null ? "ADD" : "Edit"} TODO",
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
            width: MediaQuery.of(context).size.width > midwidth
                ? 600
                : MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<DataController>(
            builder: (context, dataController, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: MediaQuery.of(context).size.width > midwidth
                    ? 600
                    : MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: blue,
                    border: Border.all(width: 1, color: darkBlue),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                  onPressed: () {
                    if (todo == null) {
                      if (datePickStr == "") {
                        datePick = DateTime.now();
                        datePickStr = DateFormat('yyyy-MM-dd').format(datePick);
                      }

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
                        nameTODOStr = "";
                        descriptionStr = "";
                        datePickStr = "";
                      });
                    } else {
                      dataController.editData(todo!, nameController.text.trim(),
                          descriptionController.text.trim(), datePickStr);
                      // setState(() {

                      //   todo!.name = nameController.text.trim();
                      //   todo!.description = descriptionController.text.trim();
                      //   todo!.dateDue = datePickStr;
                      // });
                    }
                  },
                  child: Text(
                    todo == null ? "ADD" : "Edit",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
    ;
  }
}


  //if todo null then the method will add new todo
  // //if todo not null the method will edit the todo

  // Container formEditAdd(TODO? todo) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       vertical: 10,
  //     ),
  //     decoration: const BoxDecoration(
  //         color: Color.fromARGB(247, 255, 255, 255),
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           "${todo == null ? "ADD" : "Edit"} TODO",
  //           style: const TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 25,
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.only(top: 8),
  //           decoration: const BoxDecoration(
  //               border: Border(
  //                   top: BorderSide(
  //                       color: Color.fromARGB(179, 0, 0, 0), width: 1))),
  //           height: 15,
  //         ),
  //         Container(
  //           width: MediaQuery.of(context).size.width > midwidth
  //               ? 600
  //               : MediaQuery.of(context).size.width,
  //           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //           child: Column(
  //             children: [
  //               TextField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   label: Text(
  //                     "TODO Name",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 17,
  //                     ),
  //                   ),
  //                 ),
  //                 onChanged: (value) {
  //                   nameTODOStr = value;
  //                 },
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               TextField(
  //                 controller: descriptionController,
  //                 maxLines: 2,
  //                 minLines: 1,
  //                 decoration: const InputDecoration(
  //                   counterStyle: TextStyle(fontWeight: FontWeight.bold),
  //                   border: OutlineInputBorder(),
  //                   label: Text(
  //                     "Description",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 17,
  //                     ),
  //                   ),
  //                 ),
  //                 onChanged: (value) {
  //                   descriptionStr = value;
  //                 },
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Expanded(
  //                     flex: 2,
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                           color: lightBlue,
  //                           border: Border.all(
  //                             width: 1,
  //                           ),
  //                           borderRadius: const BorderRadius.all(
  //                             Radius.circular(5),
  //                           )),
  //                       child: MaterialButton(
  //                         hoverColor: Colors.black38,
  //                         onPressed: () {
  //                           showDatePicker(
  //                             context: context,
  //                             initialDate: DateTime.now(),
  //                             firstDate: DateTime.now(),
  //                             lastDate: DateTime(2030),
  //                           ).then((date) {
  //                             setState(() {
  //                               datePick = date!;
  //                               datePickStr =
  //                                   DateFormat('yyyy-MM-dd').format(datePick);
  //                             });
  //                           });
  //                         },
  //                         child: const Text(
  //                           "Due Date",
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 40,
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Text(
  //                       datePickStr,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 17,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Consumer<DataController>(
  //           builder: (context, dataController, child) {
  //             return Container(
  //               width: MediaQuery.of(context).size.width > midwidth
  //                   ? 600
  //                   : MediaQuery.of(context).size.width,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                   color: blue,
  //                   border: Border.all(width: 1, color: darkBlue),
  //                   borderRadius: const BorderRadius.all(Radius.circular(30))),
  //               child: MaterialButton(
  //                 onPressed: () {
  //                   if (todo == null) {
  //                     TODO newTodo = TODO(
  //                       nameTODOStr.trim(),
  //                       descriptionStr.trim(),
  //                       datePickStr,
  //                       DateTime.now(),
  //                     );

  //                     dataController.addTODO(newTodo);

  //                     setState(() {
  //                       nameController.clear();
  //                       descriptionController.clear();
  //                       datePick = DateTime.now();
  //                     });
  //                   } else {
  //                     setState(() {
  //                       todo.name = nameController.text.trim();
  //                       todo.description = descriptionController.text.trim();
  //                       todo.dateDue = datePickStr;
  //                     });
  //                   }
  //                 },
  //                 child: Text(
  //                   todo == null ? "ADD" : "Edit",
  //                   style: const TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white),
  //                 ),
  //               ),
  //             );
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }