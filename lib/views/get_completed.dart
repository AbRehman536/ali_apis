import 'package:ali_apis/models/taskListing.dart';
import 'package:ali_apis/services/task.dart';
import 'package:ali_apis/views/create_task.dart';
import 'package:ali_apis/views/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_token.dart';

class GetCompletedTask extends StatelessWidget {
  const GetCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Task"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: FutureProvider.value(
        value: TaskServices().getCompletedTask(userProvider.getToken().toString()),
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
            );
          },);
        },

      ),
    );
  }
}
