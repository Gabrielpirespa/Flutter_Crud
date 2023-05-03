import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/task_model.dart';
import 'package:uuid/uuid.dart';

import '../db/task_dao.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];

  Future insertInDatabase(String activity, String date) async {
    final newTask =
        TaskModel(taskId: const Uuid().v1(), activity: activity, date: date);
    tasks.add(newTask);
    await TaskDao().save(TaskModel(
        taskId: newTask.taskId,
        activity: newTask.activity,
        date: newTask.date));
    notifyListeners();
  }

  Future<List<TaskModel>> readFromDatabase() async{
    final taskList = await TaskDao().findAll();
    tasks = taskList;
    return tasks;
  }

  Future updateFromDatabase(String taskId, String activity, String date,) async{
    final updatedTask = TaskModel(taskId: taskId, activity: activity, date: date);
    await TaskDao().update(updatedTask);
    notifyListeners();
  }

  Future deleteFromDatabase(String taskId) async{
    await TaskDao().delete(taskId);
    notifyListeners();
  }
}
