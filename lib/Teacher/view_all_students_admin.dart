import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../Student.dart';
import '../Services.dart';
import 'dart:async';
import '../login.dart';

class ViewAllStudent extends StatefulWidget {

  ViewAllStudent() : super();

  final String title = 'Students';

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

class DataTableDemoState extends State<ViewAllStudent> {
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
    _showProgress('Loading Students...');
    Services.ViewAllStudent().then((Book) {
      setState(() {
        _employees = Book;
        _filterEmployees = Book;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${Book.length}");
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
                    .where((u) => (u.name.toLowerCase().contains(string) || u.adno.toLowerCase().contains(string)|| u.dept.toLowerCase().contains(string)||
                    u.batch.toLowerCase().contains(string)))
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
                    leading: CircleAvatar(child: Text(Book.adno),backgroundColor: Colors.amber,foregroundColor: Colors.black,radius: 24,),
                    title: Text(Book.name.toUpperCase(),style: TextStyle(color: Colors.yellow[800], fontSize: 13,fontWeight: FontWeight.bold)),

                    subtitle: Text(Book.batch.toUpperCase()),

                    trailing:Icon(Icons.arrow_forward),
                    onTap: () {
                      // This Will Call When User Click On ListView Item
                     //showDialogFunc(context,Book.firstName, Book.lastName.toUpperCase(), Book.edition, Book.bino, Book.status,Book.rate,Book.category);
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
