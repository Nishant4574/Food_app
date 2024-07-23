import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Fortgotpassword extends StatefulWidget {
  const Fortgotpassword({super.key});

  @override
  State<Fortgotpassword> createState() => _FortgotpasswordState();
}

class _FortgotpasswordState extends State<Fortgotpassword> {
  TextEditingController mailcontroller = new TextEditingController();
  String email ="";
  final _formkey=GlobalKey<FormState>();
  resetpassword()async{
   try {
     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
     ScaffoldMessenger.of(context).showSnackBar((SnackBar(
         content: Text("Password Reset", style: TextStyle(fontSize: 18),))));
   }on FirebaseException catch(e){
     if(e.code=="user-not-found"){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for this email",style: TextStyle(fontSize: 18),)));
     }
   }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            SizedBox(

            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Text("Password Recovery",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Enter your mail",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          Expanded(child: Form(
            key: _formkey,

            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70,width: 2)
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return "Please enter Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        

hintText: "Email",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.white)
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: mailcontroller,


                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                            if(_formkey.currentState!.validate()){
                              setState(() {
                                email=mailcontroller.text;
                              });
                              resetpassword();
                            }
                          },
                          child: Container(
                            width: 140,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)

                            ),
                            child: Center(child: Text("Send Email",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),
            ),
          )),


          ],
        ),
      ),
    );
  }
}
