import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:e_commerce/pages/details.dart';
import 'package:e_commerce/service/database.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 bool icecream =false ,pizza =false,burger =false,salad =false;


Stream? foodItemStream;
onload()async{
  foodItemStream =await DatabaseMethods().getFoodItem("Pizza");
  setState(() {

  });
}

@override
  void initState() {
   onload();
    super.initState();
  }
 Widget allItemsVertical(){
   return StreamBuilder(stream: foodItemStream, builder: (context,AsyncSnapshot snapshot){
     return snapshot.hasData?ListView.builder(
         padding: EdgeInsets.zero,
         itemCount: snapshot.data.docs.length,
         scrollDirection: Axis.vertical,
         shrinkWrap: true,
         itemBuilder: (context,index){
           DocumentSnapshot ds =snapshot.data.docs[index];
           return   GestureDetector(
             onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(name: ds["Name"], price: ds["Price"], detail: ds["Detail"], image: ds["Image"],)));},
             child: Container(
               margin: EdgeInsets.all(4),
               child: Material(
                 elevation: 5,
                 borderRadius: BorderRadius.circular(20),
                 child: Container(
                   padding: EdgeInsets.all(10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Row(

                         children: [
                           ClipRRect(
                               borderRadius: BorderRadius.circular(20),
                               child: Image.network(ds["Image"],height: 100,width: 100,fit: BoxFit.cover)),
                           SizedBox(
                             width: 10,
                           ),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [
                               Text(ds['Name'],style: AppWidget.SemiboldTextFieldbold(),),

                               Text("Fresh and Healthy",style: AppWidget.LightTextFieldbold(),),
                               Text("\$"+ds["Price"],style: AppWidget.SemiboldTextFieldbold(),)
                             ],
                           )
                         ],
                       )

                     ],
                   ),
                 ),
               ),
             ),
           );
         }):Container();
   });
 }
  Widget allItems(){
  return StreamBuilder(stream: foodItemStream, builder: (context,AsyncSnapshot snapshot){
return snapshot.hasData?ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: snapshot.data.docs.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (context,index){
DocumentSnapshot ds =snapshot.data.docs[index];
return   GestureDetector(
  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(name: ds["Name"], price: ds["Price"], detail: ds["Detail"], image: ds["Image"])));},
  child: Container(
    margin: EdgeInsets.all(4),
    child: Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(ds["Image"],height: 150,width: 150,fit: BoxFit.cover)),
            Text(ds['Name'],style: AppWidget.SemiboldTextFieldbold(),),
            Text("Fresh and Healthy",style: AppWidget.LightTextFieldbold(),),
            Text("\$"+ds["Price"],style: AppWidget.SemiboldTextFieldbold(),)

          ],
        ),
      ),
    ),
  ),
);
}):Container();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 50,left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Om ,Here",style: AppWidget.boldTextFieldbold()),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.black,

                    ),
                    child: Icon(Icons.shopping_basket,color: Colors.white,),
                  )

                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("Delicious Food",style: AppWidget.HeadlineTextFieldbold()),
              Text("Discover and get great food",style: AppWidget.LightTextFieldbold()),
              SizedBox(
                height: 20,
              ),
        showItem(),
              SizedBox(
                height: 20,
              ),
Container(
    height: 270,
    child: allItems()),
              SizedBox(height: 30,),
              Container(
                  height: 500,
                  child: allItemsVertical())

            ],
          ),
        ),
      ),
    );
  }
Widget showItem(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ()async{

            icecream=true;
            salad=false;
            pizza=false;
            burger=false;
            foodItemStream =await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {

            });
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(

              decoration: BoxDecoration(
                  color: icecream?Colors.black:Colors.white,borderRadius: BorderRadius.circular(10)

              ),
              padding: EdgeInsets.all(8),

              child: Image.asset("img/ice-cream.png",width: 50,height: 50,fit: BoxFit.cover,color: icecream?Colors.white:Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            salad = false;
            pizza = true;
            burger = false;
            foodItemStream =await DatabaseMethods().getFoodItem("Pizza");
            setState(() {

            });
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza?Colors.black:Colors.white,borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8),

              child: Image.asset("img/pizza.png",width: 50,height: 50,fit: BoxFit.cover,color: pizza?Colors.white:Colors.black,),
            ),
          ),
        ),
        GestureDetector(
          onTap: ()async{
            icecream=false;
            burger=false;
            pizza=false;
            salad=true;
            foodItemStream =await DatabaseMethods().getFoodItem("Salad");
            setState(() {

            });
          },

          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad?Colors.black:Colors.white,borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset("img/salad.png",width: 50,height: 50,fit: BoxFit.cover,color: salad?Colors.white:Colors.black,),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            salad =false;
            pizza = false;
            burger = true;
            foodItemStream =await DatabaseMethods().getFoodItem("Burger");
            setState(() {

            });
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger?Colors.black:Colors.white, borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              
              child: ClipRRect(
                  
                  child: Image.asset("img/burger.png",width: 50,height: 50,fit: BoxFit.cover,color: burger?Colors.white:Colors.black,)),
            ),
          ),
        ),

      ],
    );
}
}
