

import 'dart:convert';

import 'package:ali_apis/models/taskListing.dart';
import 'package:http/http.dart' as http;

class TaskServices{
  String baseURL = "https://todo-nu-plum-19.vercel.app/";
  ///Create Task
  ///Get All Task
  ///Get Completed Task
  ///Get InCompleted Task
  ///Update Task
  ///Delete Task
  ///Search Task
  Future<TaskListingModel> searchTask({
    required String token,
    required String keyword,
  })async{
    try{
      http.Response res = await http.get(
          Uri.parse('$baseURL/todos/search?keywords=$keyword'),
          headers : {
            'Authorization':  token
          },);
      if(res.statusCode == 200 || res.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(res.body));
      }else{
        throw res.reasonPhrase!;
      }

    }catch(e){
      throw e.toString();
    }
  }
  ///Filter Task
  Future<TaskListingModel> filterTask({
    required String token,
    required String startDate,
    required String endDate,
  })async{
    try{
      http.Response res = await http.get(
        Uri.parse('$baseURL/todos/filter?startDate=$startDate&endDate=$endDate&='),
        headers : {
          'Authorization':  token
        },);
      if(res.statusCode == 200 || res.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(res.body));
      }else{
        throw res.reasonPhrase!;
      }

    }catch(e){
      throw e.toString();
    }
  }
}