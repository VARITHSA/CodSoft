import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo with EquatableMixin {
  @HiveField(0)
  String task;

  @HiveField(1)
  String description;
  @HiveField(3)
  bool isActive;
  @HiveField(2)
  String id;
  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isActive = false,
  });

  Todo completeTask(bool currentStatus) {
    return Todo(
      id: id,
      task: task,
      description: description,
      isActive: currentStatus,
    );
  }

  @override
  // TODO: implement props

  List<Object?> get props => [task, description, id, isActive];
}

class TodoNotifier extends ChangeNotifier {
  TodoNotifier() {
    box = Hive.box<Todo>('todoBox');
  }
  late Box<Todo> box;

  List<Todo> get boxItems => box.values.toList();

  void addTask(String task, String description) {
    final String id = const Uuid().v1();
    box.add(
      Todo(
        task: task,
        description: description,
        id: id,
      ),
    );

    notifyListeners();
  }

  void finishTask(Todo task, int index, bool state) {
    final updateTask = task.completeTask(state);

    log('$updateTask');
    box.putAt(
      index,
      updateTask,
    );
    log('$boxItems');
    notifyListeners();
  }

  void removeTask(Todo task) {
    box.delete(task.id);
    log('${boxItems.length}');
    notifyListeners();
  }

  void removeAll() {
    box.clear();
    log('${boxItems.length}');
    notifyListeners();
  }
}
