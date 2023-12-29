import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';

class Todo {
  String task;
  String description;
  Todo({
    required this.task,
    required this.description,
  });
}

class TodoModel extends ChangeNotifier {
  final List<Todo> _item = [];

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_item);

  void addTask(String task, String description) {
    _item.add(Todo(task: task, description: description));
    // print(_item.toString());
    log('task : $task \n descriptions: $description ');
    log('${_item.length}');
    notifyListeners();
  }

  void removeTask(Todo task) {
    _item.remove(task);
    log('${_item.length}');
    notifyListeners();
  }

  void removeAll() {
    _item.clear();
    log('${_item.length}');
    notifyListeners();
  }
}
