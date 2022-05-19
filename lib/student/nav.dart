import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Teacher/issubook.dart';
import '../login.dart';
import 'view_issued_student.dart';
import '../student/my_booking.dart';
import 'home_screen_Student.dart';

//import 'DataTableDemo.dart';

  class Nav extends StatefulWidget {

  @override
  _NavState createState() => _NavState();

  }

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    DataTableDemo(),
    MyApp(),

    Vs(),

    Text('login gyou out soon ')
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,

              ),
              title: Text(
                'Home',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.archive,

              ),
              title: Text(
                'My Booking',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.folder_rounded,

              ),
              title: Text(
                'Issued Books',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,


              ),
              title: Text(
                'Logout',

              ),
            ),

          ],

          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 14.0,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black54,
          unselectedFontSize: 13.0,
        ),
      ),
    );
  }
}
