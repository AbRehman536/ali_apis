import 'package:ali_apis/provider/user_token.dart';
import 'package:ali_apis/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    var userProvider = Provider.of<UserProvider>(context);
    nameController = TextEditingController(
      text: userProvider.getUser()!.user!.name.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await AuthServices().updateUser(
                      token: userProvider.getToken().toString(),
                      name: nameController.text)
                      .then((val)async{
                        await AuthServices().getUser(userProvider.getToken().toString())
                            .then((userData){
                              userProvider.setUser(userData);
                        }).then((value){
                          isLoading = false;
                          setState(() {});
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Updated Successfully"),
                              actions: [
                                TextButton(onPressed: (){}, child: Text("Okay"))
                              ],
                            );
                          },);
                        });
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));


                }
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
