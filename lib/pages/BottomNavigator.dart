import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/pages/order.dart';
import 'package:e_commerce/pages/profile.dart';
import 'package:e_commerce/pages/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home.dart';

class Bottomnavigator extends StatefulWidget {

  const Bottomnavigator({super.key});

  @override
  State<Bottomnavigator> createState() => _BottomnavigatorState();
}

class _BottomnavigatorState extends State<Bottomnavigator> {
  int currentTabIndex =0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;
  @override
  void initState() {
    homepage=Home();
    order =Order();
    profile =Profile();
    wallet =Wallet();
    pages=[homepage,order,wallet,profile];
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex =index;
          });
        },
        items: [
          Icon(Icons.home_max_outlined,color: Colors.white,),
          Icon(Icons.shopping_bag_outlined,color: Colors.white,),
          Icon(Icons.wallet_giftcard_outlined,color: Colors.white,),
          Icon(Icons.person_outline,color: Colors.white,),

        ],
      ),
      body: pages[currentTabIndex]
    );
  }
}
