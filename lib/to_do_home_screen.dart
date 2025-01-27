import 'package:flutter/material.dart';

class toDoHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => toDo_HomeScreen();
}

class toDo_HomeScreen extends State<toDoHomeScreen>
{
  List<Map<String,dynamic>>mData = [
    {
        "name"      : "Saad",
    },
    {
      "name"      : "Saad",
    },
    {
      "name"      : "Saad",
    },
    {
      "name"      : "Saad",
    },
    {
      "name"      : "Saad",
    },
    {
      "name"      : "Saad",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: toDo(),
            ),
            Flexible(
              flex: 1,
              child: iconSearch(),
            ),
            SizedBox(height: 10,),

            Expanded(
              flex: 6,
              child: ListView.builder(
                itemCount: mData.length,
                  itemBuilder: (context,index){
                return Card(
                  elevation: 10,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(mData[index]["name"]),
                      subtitle: Text(mData[index]["name"],overflow: TextOverflow.ellipsis),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit),
                          Icon(Icons.delete),

                        ],
                      ),

                    ),
                  ),
                );
              })
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
                                    decoration: InputDecoration(
                                      label: Text("Enter Task Title",style: TextStyle(color: Colors.white),),
                                      hintText: "Title fo your task",
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
                                    minLines: 3,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                        label: Text("Enter Task Title",style: TextStyle(color: Colors.white),),
                                        hintText: "Title fo your task",
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
                                     {

                                     },
                                         child: Text("Add")),
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

  Widget toDo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ToDo App",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
          Icon(Icons.calendar_month_rounded),
        ],
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
