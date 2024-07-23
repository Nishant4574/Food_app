



import 'dart:io';

import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:e_commerce/service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String>items=['Ice-cream','Burger','Salad','Pizza'];
  String? value;
  TextEditingController namecontroller =TextEditingController();
  TextEditingController pricecontroller =TextEditingController();
  TextEditingController detailcontroller =TextEditingController();
  final ImagePicker _picker =ImagePicker();
  File? seletcedImage;
  Future getImage()async{
    var image =await _picker.pickImage(source: ImageSource.gallery,);
    seletcedImage =File(image!.path);
    setState(() {

    });
  }
UploadItem()async{
    if(seletcedImage!=null&&namecontroller.text!=""&&pricecontroller.text!=""&&detailcontroller!=""){
      String addId =randomAlpha(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task =firebaseStorageRef.putFile(seletcedImage!);
      var downloadUrl = await(await task).ref.getDownloadURL();
      Map<String,dynamic>addItems =({
"Image":downloadUrl,
        "Name":namecontroller.text,
        "Price":pricecontroller.text,
        "Detail":detailcontroller.text

      });
await DatabaseMethods().addFoodItem(addItems, value!).then((value){
  ScaffoldMessenger.of(context).showSnackBar((SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Uploaded Successfully",style: TextStyle(
          fontSize: 18
      ),))));
});
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item",style: AppWidget.HeadlineTextFieldbold(),),
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded,color: Colors.black54,)),


      ),
body: SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Container(
    margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  Text("Upload the Item Picture",style: AppWidget.SemiboldTextFieldbold(),),
      SizedBox(height: 20,),
       seletcedImage==null? GestureDetector(
         onTap: (){
           getImage();
         },
         child: Center(
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1.5),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),
          ),
       ):Center(
         child: Material(
           elevation: 4,
           borderRadius: BorderRadius.circular(20),
           child: Container(
             height: 150,
             width: 150,
             decoration: BoxDecoration(
                 border: Border.all(color: Colors.black,width: 1.5),
                 borderRadius: BorderRadius.circular(10)
             ),
             child:ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                 child: Image.file(seletcedImage!,fit: BoxFit.cover,))
           ),
         ),
       ),
        SizedBox(
          height: 30,
        ),
        Text("Item Name",style: AppWidget.SemiboldTextFieldbold(),),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade300
              ,
            borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            controller: namecontroller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Item Name",
              hintStyle: AppWidget.LightTextFieldbold(),

            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Item Price",style: AppWidget.SemiboldTextFieldbold(),),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade300
              ,
              borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            controller: pricecontroller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Price",
              hintStyle: AppWidget.LightTextFieldbold(),

            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Item Detail",style: AppWidget.SemiboldTextFieldbold(),),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade300
              ,
              borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            maxLines: 6,
            controller: detailcontroller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Details",
              hintStyle: AppWidget.LightTextFieldbold(),

            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Select the category",style: AppWidget.SemiboldTextFieldbold(),),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(items:
              items.map((item)=>DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,style: TextStyle(fontSize: 18,color: Colors.black),))).toList()
              ,onChanged: ((value)=>setState(() {
              this.value=value;
              })),dropdownColor: Colors.white,hint: Text("Select the Category"),iconSize: 36,icon: Icon(Icons.arrow_drop_down_circle_rounded,color: Colors.black,),value:value ,),
            ),
          )
        ),
        SizedBox(
          height: 20,
        ),
GestureDetector(
  onTap: (){
    UploadItem();
  },
  child: Center(
    child: Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black,borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
      ),
    ),
  ),
)



      ],
    ),
  ),
),
    );
  }
}
