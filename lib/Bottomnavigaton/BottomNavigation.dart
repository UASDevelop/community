import 'package:community/changes_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../profile.dart';
import '../report.dart';
import '../extrac.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Widget> _bottom = [Home(), Reports(), ChangeProfile()]; // Corrected the order of the pages
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottom[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Fixed the assignment of _currentIndex
          });
        },
        selectedItemColor:Color(0xff28AE61),
        selectedIconTheme:IconThemeData(color:Color(0xff28AE61)),
        selectedLabelStyle:TextStyle(color:Color(0xff28AE61),fontSize:15,),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color:_currentIndex==0?Color(0xff28AE61):Color(0xffB8B8D2),
            ),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
              color:_currentIndex==1?Color(0xff28AE61):Color(0xffB8B8D2),
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color:_currentIndex==2?Color(0xff28AE61):Color(0xffB8B8D2),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}