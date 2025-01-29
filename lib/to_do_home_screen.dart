import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/db_provider.dart';
import 'package:todoapp/dp_helper.dart';
import 'package:todoapp/task_desc_screen.dart';
import 'package:todoapp/task_model.dart';

class toDoHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => toDo_HomeScreen();
}

class toDo_HomeScreen extends State<toDoHomeScreen>
{
  ///add title & description
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescController = TextEditingController();

  ///update title & update description
  TextEditingController taskUpdateTitleController = TextEditingController();
  TextEditingController taskUpdateDescController = TextEditingController();

  List<TaskModel>mTask = [];
  DBHelper dbHelper = DBHelper.getInstance();

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().fetchInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
      text: TextSpan(
      text: "ToDo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Color(0xFF3F9BFD),),
        children:[
          TextSpan(text: " Manager",style: TextStyle(fontSize: 30)),
        ],
      ),
    ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: iconSearch(),
            ),
            SizedBox(height: 10,),

            Expanded(
                flex: 6,
                child: Consumer<DBProvider>(
                    builder: (ctx, provider, child){
                      mTask = ctx.watch<DBProvider>().getAllTasks();
                      return mTask.isNotEmpty ?
                        ListView.builder(
                          itemCount: provider.getAllTasks().length,
                          itemBuilder: (context,index){
                            return Card(
                              elevation: 10,
                              child: InkWell(
                                onTap: ()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> taskScreen(task: mTask[index].id,)));
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    title: Text(mTask[index].title),
                                    subtitle: Text(mTask[index].desc,overflow: TextOverflow.ellipsis),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(value: mTask[index].checked, onChanged: (bool? value){
                                          ctx.read<DBProvider>().updateTask(mTask: TaskModel(id: mTask[index].id, title: mTask[index].title, desc: mTask[index].desc, checked: value ?? false));
                                        }
                                        ),
                                        InkWell(
                                            child: Icon(Icons.edit),
                                          onTap: ()
                                          {
                                            taskUpdateTitleController.text = mTask[index].title;
                                            taskUpdateDescController.text  = mTask[index].desc;
                                
                                            showModalBottomSheet(
                                              backgroundColor: Color(0xFF3F9BFD),
                                                context: (context), builder: (_){
                                              return Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text("Update Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.white),),
                                                      SizedBox(height: 10,),
                                                      TextField(
                                                        controller: taskUpdateTitleController,
                                                        decoration: InputDecoration(
                                                            label: Text("Enter update task title",style: TextStyle(color: Colors.white),),
                                                            hintText: "Update title fo your task",
                                                            hintStyle: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(21),
                                                              borderSide: BorderSide(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(21),
                                                            )
                                                        ),
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      SizedBox(height: 20,),
                                
                                                      TextField(
                                                        controller: taskUpdateDescController,
                                                        minLines: 4,
                                                        maxLines: 8,
                                                        decoration: InputDecoration(
                                                            label: Text("Enter update task desc",style: TextStyle(color: Colors.white),),
                                                            hintText: "Update desc of your task",
                                                            hintStyle: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(21),
                                                              borderSide: BorderSide(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(21),
                                                            )
                                                        ),
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      SizedBox(height: 20,),
                                
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          ElevatedButton(onPressed: ()
                                                          async{
                                
                                                            context.read<DBProvider>().updateTask(mTask: TaskModel(title: taskUpdateTitleController.text, desc: taskUpdateDescController.text,id: mTask[index].id));
                                                            Navigator.pop(context);
                                                          },
                                                            child: Text("Update Task"),
                                
                                                          ),
                                                          ElevatedButton(onPressed: ()
                                                          {
                                                            Navigator.pop(context);
                                                          }, child: Text("Cancel")),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                
                                      IconButton(onPressed: ()
                                      async{
                                        await context.read<DBProvider>().deleteTask(taskId: mTask[index].id);
                                      }, icon: Icon(Icons.delete)),
                                
                                      ],
                                    ),
                                
                                  ),
                                ),
                              ),
                            );
                          }) : Center(child: Text("No task yet"),);
                    }
                ),
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                backgroundColor: Color(0xFF3F9BFD),

                onPressed: ()
                {
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.save,
                      size: 30,color: Colors.white,
                    ),
                    Text("ToDo",style: TextStyle(color: Colors.white),),
                  ],
                )),
            Container(
              width: 250,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF3F9BFD),
                  onPressed: ()
                  {
                    taskTitleController.text = "";
                    taskDescController.clear();
                    showModalBottomSheet(
                        backgroundColor: Color(0xFF3F9BFD),
                        context: context,
                        builder: (_){
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Text("Add Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.white),),
                                  SizedBox(height: 10,),
                                  TextField(
                                    controller: taskTitleController,
                                    decoration: InputDecoration(
                                        label: Text("Enter task title",style: TextStyle(color: Colors.white),),
                                        hintText: "Title of your task",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(21),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(21),
                                        )
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 20,),

                                  TextField(
                                    controller: taskDescController,
                                    minLines: 4,
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                        label: Text("Enter task description",style: TextStyle(color: Colors.white),),
                                        hintText: "Desc fo your task",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(21),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(21),
                                        )
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(onPressed: ()
                                      async{
                                        await context.read<DBProvider>().addTask(mTask: TaskModel(title: taskTitleController.text, desc: taskDescController.text),);
                                        Navigator.pop(context);
                                      },
                                          child: Text("Add"),

                                      ),
                                      ElevatedButton(onPressed: ()
                                      {
                                        Navigator.pop(context);
                                      }, child: Text("Cancel")),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(Icons.add, size: 30,color: Color(0xFF3F9BFD),)),
                      SizedBox(width: 10,),
                      Text("Add new task",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ),

            FloatingActionButton(
              backgroundColor: Color(0xFF3F9BFD),
              onPressed: ()
              {

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person,color: Colors.white,),
                  Text("Profile",style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconSearch() {
    return Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF3F9BFD),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ));
  }
}