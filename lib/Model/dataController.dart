import 'package:flutter/cupertino.dart';

import 'TODO.dart';

class DataController extends ChangeNotifier {
  List<TODO> list = [];
  List<TODO> tempList = [];
  void addTODO(TODO newTodo) {
    list.add(newTodo);
    tempList.add(newTodo);
    notifyListeners();
  }

  void rempveTODO(TODO todo) {
    list.remove(todo);
    tempList.remove(todo);
    notifyListeners();
  }

  void changToggle(TODO todo) {
    todo.valueToggle = !todo.valueToggle;
    notifyListeners();
  }

  void editData(TODO todo, String name, String description, String dateDue) {
    todo.name = name;
    todo.description = description;
    todo.dateDue = dateDue;
    notifyListeners();
  }

  void finalResultList(String searchStr) {
    print("bahaa ${searchStr}");
    list = tempList;
    List<TODO> resultList = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].name.contains(searchStr) ||
          list[i].description.contains(searchStr)) {
        resultList.add(list[i]);
      }
    }
    list = resultList;
    notifyListeners();
  }

  int get listSize => list.length;
}
