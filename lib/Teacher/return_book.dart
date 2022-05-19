import 'package:barcode_scan_fix/barcode_scan.dart';

import 'package:flutter/material.dart';
import '../student/home_screen_Student.dart';
import '../Services.dart';
import '../student/nav.dart';
//import 'package:intl/intl.dart. ';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "ReturnBook Local Server",
    home: ReturnBook(),
  ));
}

class ReturnBook extends StatefulWidget {
  @override
  _IssuBookState createState() => _IssuBookState();
  var name = _firstNameController.text;
}

String _titleProgress;
var _bino = '';
var _view = false;
var _firstNameController = TextEditingController();
var _lastNameController = TextEditingController();
var _firstNameController1 = TextEditingController();
var _firstNameController2 = TextEditingController();
var _borrowed = TextEditingController();

class _IssuBookState extends State<ReturnBook> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  void initState() {
    super.initState();

    _titleProgress = '';
    _view = false;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameController1 = TextEditingController();
    _firstNameController2 = TextEditingController();
  }
//////////////

////////

  _verifyReturn(bino) {
    Services.verifyReturn(bino).then((result) {
      if ('        error' == result) {
        _showAlert("Sorry", " Somting Wrong please try Again ",
            Icons.warning_amber_rounded);
        _view=false;
      } else if ('error' != result) {
        _showAlert("Done", "Book Returned Succesfully", Icons.check);
        setState(() {

          _view=false;

        });
      }
    });
  }

  _ReturnBook(a) {
    //_showProgress(a+b);

    Services.returnBook(a).then((result) {
      //print (result);
      if ('        error' == result) {
        _showAlert("Error", "Please ReScan", Icons.warning_amber_outlined);
        setState(() {
          _firstNameController.text = '';
          _lastNameController.text = '';
          disableButton();
          _firstNameController2.text = '';
          _view = false;
        });
      } else if ('        case1' != result) {
        print(result);
        enableButton();
        var str = result;
        var parts = str.split(':');
        var prefix = parts[0].trim(); // prefix: "date"
        var afix = parts[1].trim();
        //DateTime date =parts[2].trim();
        DateTime dt = DateTime.parse(parts[2].trim());
        var borow = parts.sublist(4).join(':').trim();

        final date2 = DateTime.now();
        final difference = ((date2.difference(dt).inDays) ~/ 30);
        print(difference);
        //_showProgress(prefix);
        setState(() {
          if (difference > 1) {
            _firstNameController2.text =
                parts[2].trim() + ', ' + difference.toString() + ' Months Ago';
          } else {
            _firstNameController2.text = parts[2].trim();
          }
          _view = true;

          _firstNameController1.text = prefix.toUpperCase();
          _firstNameController.text = afix.toUpperCase();

          _borrowed.text = borow;
        });
      }
    });
  }

  _showAlert(_title, _message, _icon) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_title),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _firstNameController.text = '';
                _firstNameController1.text = '';
                _lastNameController.text = '';
                _firstNameController2.text = '';
                _view = false;
                _borrowed.text = '';
              });
            },
            child: Icon(_icon),
          ),
        ],
      ),
    );
  }

  bool isEnabled = false;

  enableButton() {
    setState(() {
      isEnabled = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Return Book",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber,
          elevation: 0.5,
          actions: <Widget>[],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/a.jpg'),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                //book scan
                Visibility(
                  visible: true,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.amber, Colors.yellow]),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextField(
                      readOnly: true,
                      controller: _firstNameController1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Scan Bar Code On Text",
                        labelStyle:
                            TextStyle(fontSize: 15.0, color: Colors.black),
                        suffixIcon: FloatingActionButton(
                          backgroundColor: Colors.amber[700],
                          onPressed: () async {
                            String codeSanner = await BarcodeScanner.scan();
                            _firstNameController.text = codeSanner;
                            _bino = codeSanner;
                            _ReturnBook(codeSanner);
                          },
                          child: Icon(Icons.qr_code),
                        ),
                      ),
                    ),
                  ),
                ),
                //book scan end here
                //student id scan
                SizedBox(
                  height: 25.0,
                ),
                //book scan
                Visibility(
                  visible: _view,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.amber, Colors.yellow]),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextField(
                      readOnly: true,
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Student Name",
                        labelStyle:
                            TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Visibility(
                  visible: _view,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.amber, Colors.yellow]),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextField(
                      readOnly: true,
                      controller: _firstNameController2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Issued On",
                        labelStyle:
                            TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Visibility(
                  visible: _view,
                  child: RaisedButton(
                    onPressed: (){
                      _verifyReturn(_bino);
                    },
                    //onPressed: isEnabled ? () => _verifyReturn(_bino) : null,
                    color: Colors.amber[600],
                    textColor: Colors.black,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Save'),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                Center(
                  child: Text(_titleProgress,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      )),
                ),

/////bottom code

                /////bottom code end here
              ],
            ),
          ),
        ));
  }
}
