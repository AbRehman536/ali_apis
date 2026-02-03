import 'package:ali_apis/models/taskListing.dart';
import 'package:ali_apis/provider/user_token.dart';
import 'package:ali_apis/services/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterTask extends StatefulWidget {
  const FilterTask({super.key});

  @override
  State<FilterTask> createState() => _FilterTaskState();
}

class _FilterTaskState extends State<FilterTask> {
  DateTime? startDate;
  DateTime? endDate;
  TaskListingModel? taskListingModel;
  bool isLoading= false;
  @override
  Widget build(BuildContext context) {
    var userProvider =  Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Task"),
      ),
      body: Column(children: [
        Row(children: [
          ElevatedButton(onPressed: (){
            showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now())
                .then((val){
                  setState(() {
                    startDate = val;
                  });
            });
          }, child: Text("Start Date")),
          if(startDate != null)
            Text(DateFormat.yMMMMEEEEd().format(startDate!)),
          ElevatedButton(onPressed: (){
            showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now())
                .then((val){
                  setState(() {
                    endDate = val;
                  });
            });
          }, child: Text("End Date")),
          if(endDate != null)
            Text(DateFormat.yMMMMEEEEd().format(endDate!)),
        ],),
        ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            taskListingModel == null;
            setState(() {});
            await TaskServices().filterTask(
                token: userProvider.getToken().toString(),
                startDate: startDate.toString(),
                endDate: endDate.toString())
            .then((val){
              isLoading = false;
              taskListingModel = val;
              setState(() {});
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Filter Task")),
        if(isLoading == true)
          Center(child: CircularProgressIndicator(),),
        if(taskListingModel == null)
          Center(child:  Text("No Data Found"),)
        else
          ListView.builder(itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.task),
              title: Text(taskListingModel!.tasks![index].description.toString()),
            );
          }
          )
      ],),
    );

  }
}
