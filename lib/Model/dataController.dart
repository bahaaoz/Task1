import 'package:flutter/cupertino.dart';

import 'TODO.dart';

class DataController extends ChangeNotifier {
  List<TODO> list = [];

  void addTODO(TODO newTodo) {
    list.add(newTodo);
    notifyListeners();
  }

  void rempveTODO(TODO todo) {
    list.remove(todo);
    notifyListeners();
  }

  void changToggle(TODO todo) {
    todo.valueToggle = !todo.valueToggle;
    notifyListeners();
  }

  int get listSize => list.length;
}
