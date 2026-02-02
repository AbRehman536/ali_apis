import 'package:ali_apis/models/taskListing.dart';
import 'package:ali_apis/services/task.dart';
import 'package:ali_apis/views/create_task.dart';
import 'package:ali_apis/views/get_completed.dart';
import 'package:ali_apis/views/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_token.dart';
import 'get_incompleted.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: FutureProvider.value(
          value: TaskServices().getAllTask(userProvider.getToken().toString()),
          initialData: [TaskListingModel()],
          builder: (context, child){
            TaskListingModel taskListingModel = context.watch<TaskListingModel>();
            if(taskListingModel.tasks == null){
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskListingModel.tasks![index].description.toString()),
                trailing: Row(children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskListingModel.tasks![index])));
                  }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: ()async{
                    try{
                      await TaskServices().deleteTask(
                          token: userProvider.getToken().toString(),
                          taskID: taskListingModel.tasks![index].id.toString());
                    }catch(e){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }, icon: Icon(Icons.delete)),
                ],),
              );
            },);
          },

      ),
    );
  }
}
