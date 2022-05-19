import 'package:flutter/material.dart';
import 'package:my_library/Admins/addstudent.dart';
import 'package:my_library/Teacher/View_all_bookings%20_admin.dart';
import 'package:my_library/Teacher/view_all_books_admin.dart';
import 'package:my_library/Teacher/view_all_issued_admin.dart';
import 'package:my_library/Teacher/view_all_students_admin.dart';
import 'package:my_library/Admins/register_page.dart';
import 'package:my_library/Admins/addbook.dart';
void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage2(),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        elevation: 0.5,
        actions: <Widget>[],
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.amber[600],
                width: 10.0,
                height: 15.0,
              ),
              new ListTile(
                leading: Icon(
                  Icons.stacked_line_chart,
                  color: Colors.amber,
                ),
                title: new Text('All Books'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllBooks()),
                  );
                },
              ),
              new ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Colors.amber,
                  ),
                  title: new Text('Bookings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewAllBooking()),
                    );
                  }),
              new ListTile(
                leading: Icon(
                  Icons.search_sharp,
                  color: Colors.amber,
                ),
                title: new Text('Issued'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllIssued()),
                  );
                },
              ),
              new ListTile(
                leading: Icon(
                  Icons.person_search_outlined,
                  color: Colors.amber,
                ),
                title: new Text('Students'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllStudent()),
                  );
                },
              ),

              new ListTile(
                leading: Icon(
                  Icons.monetization_on_sharp,
                  color: Colors.amber,
                ),
                title: new Text('Fine & Due'),
                onTap: () {},
              ),
              new ListTile(
                leading: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: Colors.amber,
                ),
                title: new Text('Add Teacher'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
              new ListTile(
                leading: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: Colors.amber,
                ),
                title: new Text('Add Book'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addbook()),
                  );
                },
              ),

              new ListTile(
                leading: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: Colors.amber,
                ),
                title: new Text('Add Student'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addstudent()),
                  );
                },
              ),
            ],
          )),

    );
  }
}
