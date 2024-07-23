import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:e_commerce/pages/BottomNavigator.dart';
import 'package:e_commerce/pages/Sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'fortgotpassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email="",password ="";
  final _formkey =GlobalKey<FormState>();
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();
  UserLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottomnavigator()));
    }on FirebaseException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("No user found for this email",style: TextStyle(fontSize: 18),)));
      }else if(e.code=="wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Password",style: TextStyle(fontSize: 18),)

        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.deepOrange,
                          Colors.deepOrangeAccent,
                          Colors.redAccent
                        ])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20))),
                child: Text(""),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "img/logo.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    )),
                    SizedBox(
                      height: 50,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text("Login",
                                    style: AppWidget.HeadlineTextFieldbold()),
                                TextFormField(
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Please enter email";
                                    }
                                    return null;
                                  },
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle:
                                          AppWidget.SemiboldTextFieldbold(),
                                      prefixIcon: Icon(Icons.email_outlined)),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Please enter password";
                                    }
                                    return  null;
                                  },

                                  controller: passwordcontroller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle:
                                          AppWidget.SemiboldTextFieldbold(),
                                      prefixIcon: Icon(Icons.lock)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                   GestureDetector(
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Fortgotpassword()));
                                     },
                                     child: Container(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "Forgot password?",
                                          style: AppWidget.SemiboldTextFieldbold(),
                                        )),
                                   ),

                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        password=passwordcontroller.text;
                                        email =emailcontroller.text;
                                      });
                                    }
                                    UserLogin();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                        child: Text("Don't have an account? Sign up",style: AppWidget.SemiboldTextFieldbold(),))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
