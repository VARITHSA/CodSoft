import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  String task;

  @HiveField(1)
  String description;

  Todo({
    required this.task,
    required this.description,
  });
}

class TodoModel extends ChangeNotifier {
  final List<Todo> _item = [];
  Box box = Hive.box('todoBox');
  bool isActive = false;
  UnmodifiableListView<Todo> get items => UnmodifiableListView(_item);

  void addTask(String task, String description) {
    _item.add(Todo(task: task, description: description));
    box.put('key', Todo(task: task, description: description));
    // print(_item.toString());
    log('task : $task \n descriptions: $description ');
    log('${_item.length}');
    notifyListeners();
  }

  bool showDes() {
    isActive = !isActive;
    log('$isActive');
    
    notifyListeners();
    return isActive;
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
