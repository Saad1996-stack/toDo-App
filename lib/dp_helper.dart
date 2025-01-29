import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/task_model.dart';

class DBHelper
{
  ///TABLE NAME
  static const String TABLE_TASK = "task";

  ///COLUMN NAMES

  static const String COLUMN_TASK_ID = "task_id";
  static const String COLUMN_TASK_TITLE = "task_title";
  static const String COLUMN_TASK_DESC = "task_desc";
  static const String COLUMN_TASK_CHECKED = "checked";

  DBHelper._();
  static DBHelper getInstance()=> DBHelper._();

  Database? mDB;

  Future<Database>getDB()
  async{
    return mDB ?? await openDB();
  }

  Future<Database>openDB()
  async{
    var appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "mainDB.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db,version){
      db.execute("create table $TABLE_TASK ( $COLUMN_TASK_ID integer primary key autoincrement, $COLUMN_TASK_TITLE text, $COLUMN_TASK_DESC text, $COLUMN_TASK_CHECKED integer)");
    });
  }

  Future<bool>addTask({required TaskModel newTask})
  async{
    var db = await getDB();
    int rowsEffected = await db.insert(TABLE_TASK, newTask.toMap());
    return rowsEffected>0;
  }

  Future<List<TaskModel>>fetchAllTask()
  async{
    var db = await getDB();
    List<Map<String,dynamic>> mData = await db.query(TABLE_TASK);
    List<TaskModel>mTask = [];

    for(int i=0; i<mData.length; i++)
      {
        TaskModel eachNote = TaskModel.fromMap(mData[i]);
        mTask.add(eachNote);
      }
    return mTask;
  }

  Future<bool>updatedTask({required TaskModel updateModel})
  async{
    var db = await getDB();
    int rowsEffected = await db.update(
        TABLE_TASK, updateModel.toMap(),
        where: "$COLUMN_TASK_ID = ${updateModel.id}");
    return rowsEffected>0;
  }

  Future<bool>deleteTask({required int id})
  async{
    var db = await getDB();
    int rowsEffected = await db.delete(TABLE_TASK,
        where: "$COLUMN_TASK_ID = $id");
    return rowsEffected>0;
  }
}