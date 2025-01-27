import 'package:flutter/cupertino.dart';
import 'package:todoapp/dp_helper.dart';
import 'package:todoapp/task_model.dart';

class DbProvider extends ChangeNotifier
{
  List<TaskModel>_mTask = [];
  List<TaskModel>getAllNotes() => _mTask;

  DBHelper dbHelper;
  DbProvider({required this.dbHelper});

  void addTask({required TaskModel mTask})
  async{
    bool check = await dbHelper.addTask(newTask: mTask);
    if(check)
      {
        _mTask = await dbHelper.fetchAllTask();
        notifyListeners();
      }
  }

  void fetchInitialNotes({required TaskModel mTask})
  async{
    _mTask = await dbHelper.fetchAllTask();
    notifyListeners();
  }

  void updateTask({required TaskModel mTask})
  async{
    bool check = await dbHelper.updatedTask(updateModel: mTask);
    if(check)
      {
        _mTask = await dbHelper.fetchAllTask();
        notifyListeners();
      }
  }
  
  void deleteTask({required int taskId})
  async{
    bool check = await dbHelper.deleteTask(id: taskId);
    if(check)
      {
        _mTask = await dbHelper.fetchAllTask();
        notifyListeners();
      }
  }
}