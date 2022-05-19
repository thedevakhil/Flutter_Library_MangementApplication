import 'package:flutter/material.dart';
import '../Student.dart';
import '../Services.dart';
import 'dart:async';
import '../login.dart';

class ViewAllBooks extends StatefulWidget {

  ViewAllBooks() : super();

  final String title = 'Books';

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds), action);
  }
}

class DataTableDemoState extends State<ViewAllBooks> {
  List<Book> _employees;
  List<Book> _filterEmployees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  var _studentid;
  Employee _selectedEmployee;
  bool visible = true;
  String _titleProgress;
  Icon _searchIcon = new Icon(Icons.search);
  final _debouncer = Debouncer(milliseconds: 500);
  Widget _appBarTitle = new Text('Home');

  @override
  void initState() {
    super.initState();
    _employees = [];
    _filterEmployees = [];

    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _studentid = Login().name;
    _getAllBooks();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _appBarTitle = new Text(message);

    });
  }


  _getAllBooks() {
    _showProgress('Loading Books...');
    Services.getallbooks().then((Books) {
      setState(() {
        _employees = Books;
        _filterEmployees = Books;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${Books.length}");
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  // Let's create a DataTable and show the employee list in it.


  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
            prefixIcon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Search... ',
            focusColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onChanged: (string) {
            _debouncer.run(() {
              setState(() {
                _filterEmployees = _employees
                    .where((u) => (u.firstName.toLowerCase().contains(string) || u.firstName.toUpperCase().contains(string) ||u.bino.toLowerCase().contains(string)||
                    u.lastName.toLowerCase().contains(string)))
                    .toList();
              });
            });
          },
        );
      } else {
        _filterEmployees=_employees;
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(_titleProgress);
      }
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _appBarTitle,
        backgroundColor: Colors.amber, // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            color: Colors.white,
            onPressed: _searchPressed,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getAllBooks();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(

                children:  _filterEmployees
                    .map(
                      (Book) =>ListTile(
                  //key: cardB,
                  leading: CircleAvatar(child: Text(Book.bino.substring(0, 4)),backgroundColor: Colors.amber,foregroundColor: Colors.black,radius: 24,),
                  title: Text(Book.firstName.toUpperCase(),style: TextStyle(color: Colors.yellow[800], fontSize: 13,fontWeight: FontWeight.bold)),

                  subtitle: Text(Book.lastName.toUpperCase()),

                  trailing:Icon(Icons.arrow_forward),
                  onTap: () {
                    // This Will Call When User Click On ListView Item
                    showDialogFunc(context,Book.firstName, Book.lastName.toUpperCase(), Book.edition, Book.bino, Book.status,Book.rate,Book.category);
                  },


                ),

                )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
showDialogFunc(context,title, author, edition, isd,status,rate,category) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                  color: Colors.amber,
                  width: 5.0,
                  style: BorderStyle.solid),
            ),

            padding: EdgeInsets.all(15),
            height: 350,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,

                      child: Image.asset('images/b.jpg',height: 60,),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'BOOK ID : '+isd,
                  textAlign: TextAlign.left,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  'By '+author,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'EDITION : '+edition,
                  textAlign: TextAlign.right,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  'RATE: '+rate,
                  textAlign: TextAlign.left,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'STATUS: '+status,
                  textAlign: TextAlign.left,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      );
    },
  );
}
