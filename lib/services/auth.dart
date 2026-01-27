import 'dart:convert';

import 'package:ali_apis/models/login.dart';
import 'package:ali_apis/models/profile.dart';
import 'package:ali_apis/models/register.dart';

import 'package:http/http.dart' as http;

class AuthServices{
  String baseURL = "https://todo-nu-plum-19.vercel.app/";
  ///Register user
  Future<RegisterModel> registerUser({
    required String name,
    required String email,
    required String password,
})async{
    try{
      http.Response res = await http.post(
        Uri.parse('$baseURL/users/register'),
          headers : {
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'name': name,
            'email': email,
            'password': password,
          }));
      if(res.statusCode == 200 || res.statusCode == 201) {
        return RegisterModel.fromJson(jsonDecode(res.body));
      }else{
        throw res.reasonPhrase!;
      }

    }catch(e){
      throw e.toString();
    }
  }
///Login User
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  })async{
    try{
      http.Response res = await http.post(
          Uri.parse('$baseURL/users/login'),
          headers : {
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'email': email,
            'password': password,
          }));
      if(res.statusCode == 200 || res.statusCode == 201) {
        return LoginModel.fromJson(jsonDecode(res.body));
      }else{
        throw res.reasonPhrase!;
      }

    }catch(e){
      throw e.toString();
    }
  }
  ///Get Profile
  Future<UserModel> getUser(String token)async{
    try{
      http.Response res = await http.get(
          Uri.parse('$baseURL/users/profile'),
          headers : {
            'Authorization': token
          },);
      if(res.statusCode == 200 || res.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(res.body));
      }else{
        throw res.reasonPhrase!;
      }

    }catch(e){
      throw e.toString();
    }
  }
///Update Profile
  Future<UserModel> updateUser({required String token,required String name})
  async{
    try{
      http.Response res = await http.put(
        Uri.parse('$baseURL/users/profile'),
        headers : {
          'Authorization': token,
          'Content-Type': 'application/json'
        },
          body: json.encode({
            'name': name,
          }));
      if(res.statusCode == 200 || res.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(res.body));
      }else{
        throw res.reasonPhrase!;
      }

    }catch(e){
      throw e.toString();
    }
  }
}