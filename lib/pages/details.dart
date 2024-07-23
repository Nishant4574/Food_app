import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:e_commerce/home.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/sharedsPref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String image,name,detail,price;
 Details({super.key,required this.name,required this.image,required this.detail,required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {


  int a =1;
  int total=0;
  String?id;
  getsharedPreference()async{
    id =await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }
  onloading()async{
    await getsharedPreference();
    setState(() {

    });
  }

@override
  void initState() {
    onloading();
total =int.parse(widget.price);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              child:   Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),
              
            ),
Image.network(widget.image,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/2.5,fit:BoxFit.fill,),
         SizedBox(
           height: 15
           ,
         ),

            Row
              (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(widget.name,style: AppWidget.SemiboldTextFieldbold(),),

                ],
              ),
Spacer(),
              GestureDetector(
                onTap: (){
                  if(a>1){
                    --a;
                    total =total-int.parse(widget.price);
                  }

                  setState(() {
                    
                  });
                },
                child: Container(

                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.remove,color: Colors.white,),
                ),
              ),
                SizedBox(
                  width: 10,
                ),
                Text(a.toString(),style: AppWidget.SemiboldTextFieldbold(),),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: (){
                    ++a;
                    total =total+int.parse(widget.price);
                    setState(() {

                    });
                  },
                  child: Container(
                  
                    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.add,color: Colors.white,),
                  ),
                )
            ],),
            SizedBox(height: 20,),
           Text(widget.detail,style: AppWidget.LightTextFieldbold(),),
          SizedBox(height: 30,),
           Row(
             children: [

               SizedBox(height: 30,),
               Text("Delivery Date",style: AppWidget.SemiboldTextFieldbold()),
               SizedBox(
                 width: 20,
               ),
               Icon((Icons.alarm_on),color: Colors.black,),

               Text("30min",style: AppWidget.SemiboldTextFieldbold(),)
             ],
           ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price",style: AppWidget.SemiboldTextFieldbold(),),
                      Text("\$"+total.toString(),style: AppWidget.boldTextFieldbold(),)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
child: Row(
  children: [

    Container(
      width: MediaQuery.of(context).size.width/2,

      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Add to Cart",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontSize: 16),),
          SizedBox(width: 40,),

          GestureDetector(
            onTap: ()async{
              Map<String,dynamic> addFoodCart =({
"Name":widget.name,
                "Quantity":a.toString(),
                "Total":total.toString(),
                "Image":widget.image
              });
              await DatabaseMethods().addFoodToCart(addFoodCart, id.toString());
              ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                  backgroundColor: Colors.yellow,
                  content: Text("Food added to Cart",style: TextStyle(
                      fontSize: 18,color: Colors.black
                  ),))));
            },
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.grey,borderRadius: BorderRadius.circular(8)
              ),
              child: Icon(Icons.shopping_cart_outlined,color: Colors.white,),
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      
    ),

  ],
),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
