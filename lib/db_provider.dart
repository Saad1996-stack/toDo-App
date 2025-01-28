import 'package:flutter/cupertino.dart';
import 'package:todoapp/dp_helper.dart';
import 'package:todoapp/task_model.dart';

class DBProvider extends ChangeNotifier
{
  List<TaskModel>_mTask = [];

  DBHelper dbHelper;
  DBProvider({required this.dbHelper});

  List<TaskModel>getAllTasks() => _mTask;

  Future<void> addTask({required TaskModel mTask})
  async{
    bool check = await dbHelper.addTask(newTask: mTask);
    if(check)
      {
        _mTask = await dbHelper.fetchAllTask();
        notifyListeners();
      }
  }

  Future<void> fetchInitialNotes()
  async{
    _mTask = await dbHelper.fetchAllTask();
    notifyListeners();
  }

  Future<void> updateTask({required TaskModel mTask})
  async{
    bool check = await dbHelper.updatedTask(updateModel: mTask);
    if(check)
      {
        _mTask = await dbHelper.fetchAllTask();
        notifyListeners();
      }
  }
  
  Future<void> deleteTask({required int taskId})
  async{
    bool check = await dbHelper.deleteTask(id: taskId);
    if(check)
      {
        _mTask = await dbHelper.fetchAllTask();
        print("Tasks After Delete: $_mTask");
        notifyListeners();
      }
  }
}