import 'package:e_commerce/home.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/sharedsPref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../Widget/Widget_support.dart';
import 'BottomNavigator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email="",password="",name="";
  TextEditingController namecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  final _formkey =GlobalKey<FormState>();
  Registration()async{
    if(password!=null){
      try{
        UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((

            SnackBar(
                backgroundColor: Colors.redAccent,
                content:Text("Registration Succesfull",style: TextStyle(fontSize: 20),
        ) )));
String Id =randomAlphaNumeric(10);
Map<String,dynamic> addUserInfo={
  "Name":namecontroller.text,
  "Email":emailcontroller.text,
  "Wallet":"0",
  "Id":Id,
};
await DatabaseMethods().addUserDetail(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);

await SharedPreferenceHelper().saveUserWallet("0");
await SharedPreferenceHelper().saveUserId(Id);

Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bottomnavigator()));
      } on FirebaseException catch(e){
if(e.code=="weak-password"){
  ScaffoldMessenger.of(context).showSnackBar((SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Password Provided is very weak",style: TextStyle(
    fontSize: 18
  ),))));

}else if(e.code=="email-already-in-use"){
  ScaffoldMessenger.of(context).showSnackBar((SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Account already exist"))));
}
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
                          height: MediaQuery.of(context).size.height / 1.7,
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
                                Text("Sign Up",
                                    style: AppWidget.HeadlineTextFieldbold()),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: namecontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Enter your name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "User Name",
                                      hintStyle:
                                      AppWidget.SemiboldTextFieldbold(),
                                      prefixIcon: Icon(Icons.person_outline)),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  controller: emailcontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Enter your email";
                                    }
                                    return null;
                                  },
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

                                  controller: passwordcontroller,
                                  validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Enter your password";
                                    }
                                    return null;
                                  },
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



                                  Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                       "",
                                        style: AppWidget.SemiboldTextFieldbold(),
                                      )),

                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    if(_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = emailcontroller.text;
                                        password = passwordcontroller.text;
                                        name = namecontroller.text;
                                      });
                                    }
                                    Registration();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                          "Sign Up",
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: Text("Already Login an account? Login",style: AppWidget.SemiboldTextFieldbold(),))
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
