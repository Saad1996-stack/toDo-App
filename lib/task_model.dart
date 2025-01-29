import 'package:todoapp/dp_helper.dart';

class TaskModel
{
  int id;
  String title;
  String desc;
  bool checked;

  TaskModel({this.id = 0, required this.title, required this.desc, this.checked  = false});

  factory TaskModel.fromMap(Map<String,dynamic>map)
  {
    return TaskModel(
      id: map[DBHelper.COLUMN_TASK_ID],
      title: map[DBHelper.COLUMN_TASK_TITLE],
      desc: map[DBHelper.COLUMN_TASK_DESC],
      checked: map[DBHelper.COLUMN_TASK_CHECKED] == 1,

    );
  }

  Map<String,dynamic>toMap()
  {
    return {
      DBHelper.COLUMN_TASK_TITLE : title,
      DBHelper.COLUMN_TASK_DESC  : desc,
      DBHelper.COLUMN_TASK_CHECKED : checked ? 1 : 0,
    };
  }
}