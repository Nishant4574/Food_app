import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Admin_Page.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();
  final GlobalKey<FormState>_formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/2 ),
              padding: EdgeInsets.only(top: 45,left: 20,right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(

                gradient: LinearGradient(colors: [Colors.orange,Colors.redAccent],begin: Alignment.topLeft,end: Alignment.bottomRight),borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.height, 110))),
            ),
            Container(
              margin: EdgeInsets.only(left: 30,right: 30,top: 60),
              child: Form(key: _formkey,child: Column(

                children: [
                  Text("Let's start with Admin!",style: TextStyle(color: Colors.black54,fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: 35,),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height/2.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),


                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          Container(
                            padding: EdgeInsets.only(left: 20,top: 5,bottom:5 ),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  helperStyle: TextStyle(color: Colors.grey),


                                ),
                                controller: usernamecontroller,
                                validator: (value){
                                  if(value==null||value.isEmpty){
return "Please enter user name";
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20,top: 5,bottom:5 ),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextFormField(

                                decoration: InputDecoration(
                                    hintText: "Enter password ",
                                    helperStyle: TextStyle(color: Colors.grey),

                                ),
                                controller: passwordcontroller,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "Please enter user name";
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: (){
                              LoginAdmin();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                            color: Colors.black,borderRadius: BorderRadius.circular(20)
                              ),
                            child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )

              ),
            )
          ],
        ),
      ),
    );
  }
  LoginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
    snapshot.docs.forEach((result){
 if(result.data()['id']!=usernamecontroller.text.trim()){
   ScaffoldMessenger.of(context).showSnackBar((SnackBar(
       backgroundColor: Colors.redAccent,
       content: Text("Your Id is not correct",style: TextStyle(
           fontSize: 18
   )))));
 }else  if(result.data()['password']!=passwordcontroller.text.trim()){
   ScaffoldMessenger.of(context).showSnackBar((SnackBar(
       backgroundColor: Colors.redAccent,
       content: Text("Password is incorrect",style: TextStyle(
           fontSize: 18
       )))));
 }else{
   Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPage()));
 };
    });
    });
  }
}
