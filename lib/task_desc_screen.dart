import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/task_model.dart';

import 'db_provider.dart';

class taskScreen extends StatefulWidget
{
  final int task;
  taskScreen({required this.task});

  @override
  State<StatefulWidget> createState() => taskDescScreen();
}

class taskDescScreen extends State<taskScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        backgroundColor: Color(0xFF3F9BFD),
      appBar: AppBar(
        title: Text("View Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: Color(0xFF3F9BFD),
      ),
      body:Consumer<DBProvider>(
        builder: (ctx, provider, child)
        {
          final selectedTask = provider.getAllTasks().firstWhere(
              (task) => task.id == widget.task,
            orElse: ()=> TaskModel(title: "No Data", desc: "No Data"),
          );
          return ListView(
            children: [
              Text(selectedTask.title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.white,),),
              SizedBox(height: 20,),
              Text(selectedTask.desc,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.white,),),

            ],
          );
        },
      )
    );
  }

}