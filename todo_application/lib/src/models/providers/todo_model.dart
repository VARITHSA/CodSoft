import 'dart:collection';

import 'package:flutter/foundation.dart';

class Todo {
  String title;
  String detail;
  bool isActive;
  Todo({
    required this.title,
    required this.detail,
    this.isActive = false,
  });
  void _complete() {
    isActive != isActive;
  }
}

class TodoModelProvider extends ChangeNotifier {
  List<Todo> alltodo = [];
  UnmodifiableListView<Todo> get alltasks => UnmodifiableListView(alltodo);

  void addTask(String title, String detail) {
    alltodo.add(Todo(title: title, detail: detail));
    notifyListeners();
  }

  void removeTask(Todo task) {
    alltodo.remove(task);
    notifyListeners();
  }

  void toggleTask(Todo task) {
    final taskIndex = alltodo.indexOf(task);
    alltodo[taskIndex]._complete();
    notifyListeners();
  }
}
