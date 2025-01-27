import 'package:todoapp/dp_helper.dart';

class TaskModel
{
  int id;
  String title;
  String desc;

  TaskModel({this.id = 0, required this.title, required this.desc});

  factory TaskModel.fromMap(Map<String,dynamic>map)
  {
    return TaskModel(
      id: map[DBHelper.COLUMN_TASK_ID],
      title: map[DBHelper.COLUMN_TASK_TITLE],
      desc: map[DBHelper.COLUMN_TASK_DESC],
    );
  }

  Map<String,dynamic>toMap()
  {
    return {
      DBHelper.COLUMN_TASK_TITLE : title,
      DBHelper.COLUMN_TASK_DESC  : desc,
    };
  }
}