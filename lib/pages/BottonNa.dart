import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/CartPage.dart';
import 'package:library_app/pages/bookstore_home_page.dart';
import 'package:library_app/pages/profile.dart';
class PracticeBottomNavBar extends StatefulWidget {
  const PracticeBottomNavBar({super.key});
  @override
  State<PracticeBottomNavBar> createState() => _PracticeBottomNavBarState();}
class _PracticeBottomNavBarState extends State<PracticeBottomNavBar> {
  List list = [
    NewPage(),
    ProfilePage(),
    CartPage(),
  ];
  List<Icon> allItems = [
    Icon(Icons.home,color: Colors.white,),
    Icon(Icons.person,color: Colors.white,),
    //Icon(Icons.medication_liquid_outlined,color: Colors.white,),
    Icon(Icons.book,color: Colors.white,)
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color:Colors.black,

        buttonBackgroundColor:Colors.black,
        index: _currentIndex,
        onTap: (int index){
          _currentIndex = index;
          setState(() {
          });
        },
        items: allItems,
      ),
    );  }
}