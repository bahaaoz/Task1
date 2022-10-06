import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/dataController.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: ,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                color: const Color.fromARGB(255, 215, 215, 215)),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: leftSideOfCard(index),
                ),
                Expanded(
                  flex: 1,
                  child: rightSideOfCard(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Consumer rightSideOfCard(int index) {
    return Consumer<DataController>(
      builder: (context, dataController, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                dataController.rempveTODO(dataController.list[index]);
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            Switch(
              value: dataController.list[index].valueToggle,
              onChanged: (value) {
                dataController.changToggle(value, index);
              },
            )
          ],
        );
      },
    );
  }

  Consumer leftSideOfCard(int index) {
    return Consumer<DataController>(
      builder: (context, dataController, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name : ${dataController.list[index].name}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Description : \n${dataController.list[index].description}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.yellow,
              ),
              child: Text(
                "Date : ${dataController.list[index].dateDue}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
