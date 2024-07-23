import 'package:e_commerce/Widget/Widget_support.dart';
import 'package:e_commerce/pages/Sign_up.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Widget/content_model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentpage =0;
  late PageController _controller;
  @override
  void initState() {
    _controller=PageController(initialPage:0);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
body: Column(
  children: [

    Expanded(
      child: PageView.builder(
        onPageChanged: (int index){
          setState(() {
            currentpage =index;
          });
        },
          controller: _controller,
          itemCount: contents.length,
          itemBuilder: (_,i){return Padding(padding: EdgeInsets.all(2),
      
          child:Column(
            children: [
      Image.asset(contents[i].image,height: 450,width: MediaQuery.of(context).size.width/1.5,fit: BoxFit.cover,),
              SizedBox(height: 40,),
              Text(contents[i].title ,style: AppWidget.SemiboldTextFieldbold(),),
              SizedBox(height: 40,),
              Text(contents[i].description,style: AppWidget.LightTextFieldbold(),)
            ],
          ) ,
      
      );}
      
      ),
    ),
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
          List.generate(contents.length, (index)=>
buildDot(index,context),
          )

      ),
    ),
GestureDetector(
  onTap: (){
    if(currentpage==contents.length-1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
    }
    _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  },
  child: Container(

    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(20)
    ),
    height: 40,
    margin: EdgeInsets.all(40),
    width: 200,
    child: Center(child: Text(currentpage==2?"Start":"Next",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20), )),
  
  ),
)
  ],
),
    );
  }
  Container
buildDot(int index,BuildContext context){
return Container(
  height: 10,
  width: currentpage ==index?18:7,
  margin: EdgeInsets.only(right: 5),
  decoration: BoxDecoration(color: Colors.black38,
    borderRadius: BorderRadius.circular(6)
  ),
);
  }

}
