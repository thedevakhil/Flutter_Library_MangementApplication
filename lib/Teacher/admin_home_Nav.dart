
import 'package:flutter/material.dart';
import 'package:my_library/Teacher/adhome.dart';
import 'package:my_library/Teacher/issubook.dart';
import 'package:my_library/Teacher/return_book.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "admin home",
    home: Adnav(),
  ));
}

class Adnav extends StatefulWidget {

  @override
  _NavState createState() => _NavState();

}

class _NavState extends State<Adnav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    IssuBook(),
    ReturnBook(),

    //Vs(),

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
                Icons.home,color: Colors.amber,

              ),
              title: Text(
                'Home',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.playlist_add,color: Colors.amber,

              ),
              title: Text(
                'Issue',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.reset_tv,color: Colors.amber,

              ),
              title: Text(
                'Return',

              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_outlined,color: Colors.amber,


              ),
              title: Text(
                'Bookings',

              ),
            ),

          ],

          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 14.0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          unselectedFontSize: 13.0,
        ),
      ),
    );
  }
}
