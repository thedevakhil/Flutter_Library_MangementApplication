import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../Student.dart';
import '../Services.dart';
import 'dart:async';
import '../login.dart';
////my code

//print(id.body);
////////ivide finished
class DataTableDemo extends StatefulWidget {

  DataTableDemo() : super();

  final String title = 'Books Available';

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

class DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employees;
  List<Employee> _filterEmployees;
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
    _getEmployees(Login().name);
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _appBarTitle = new Text(message);
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Now lets add an Employee
  _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      _showSnackBar(context, 'Empty Fields');
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(Login().name); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _book(a) {
    _showProgress('Booking....');
    Services.book(a, Login().name, a).then((result) {
      if ('        success' == result) {
        _getEmployees(Login().name); // Refresh the list after update

        _clearValues();
        //_getEmployees();
        print("ok Done");
      }
    });
  }

  _getEmployees(adno) {
    _showProgress('Loading Books...');
    Services.getBooks(adno).then((employees) {
      setState(() {
        _employees = employees;
        _filterEmployees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        //scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowHeight: 165,

          columns: [
            DataColumn(
              label: Text(''),
            ),

          ],
          rows: _filterEmployees
              .map(
                (employee) => DataRow(cells: [

                  DataCell(
                    ExpansionTileCard(
                      //key: cardB,
                      leading: CircleAvatar(child: Text(employee.title.toUpperCase()[0]),backgroundColor: Colors.amber,foregroundColor: Colors.black,),
                      title: Text(employee.title.toUpperCase(),style: TextStyle(color: Colors.yellow[800], fontSize: 13,fontWeight: FontWeight.bold)),
                      subtitle: Text(employee.author.toUpperCase()),
                      //trailing:
                      children: <Widget>[
                        Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Row(children: <Widget>[
                          Text('   Edition: '+employee.edition.toUpperCase()+'                                                                                     '),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.book),
                                onPressed: () {
                                  _book(employee.bino);
                                },
                              ),
                              Text('Book now'),
                            ],
                          )
                        ])

                      ],

                    ),
                  ),

                ]),
              )
              .toList(),
        ),
      ),
    );
  }

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
            hintText: 'Search...',
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
                    .where((u) => (u.title.toLowerCase().contains(string) ||
                        u.author.toLowerCase().contains(string)))
                    .toList();
              });
            });
          },
        );
      } else {
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
              _getEmployees(Login().name);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),

    );
  }
}
