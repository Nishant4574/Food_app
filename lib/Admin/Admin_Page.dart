import 'package:e_commerce/Admin/Add_food.dart';
import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(

  margin: EdgeInsets.only(top: 50,left: 20,right: 20),
  child: Column(
    children: [
      Center(
        child:
        Text("Home Admin",style: AppWidget.HeadlineTextFieldbold(),)


      ),
      SizedBox(
        height: 50,
      ),
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFood()));
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Center(
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20),

          ),
          child: Row(
            children: [
        Padding(padding: EdgeInsets.all(6),
          child: Image.asset("img/food.jpg",height: 100,width: 100,fit: BoxFit.cover,),
        ),
        SizedBox(width: 30,),
        Text("Add Food Item",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
          ),
        ),
      )
    ],
  ),
),
    );
  }
}
