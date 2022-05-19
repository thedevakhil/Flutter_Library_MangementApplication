import 'package:barcode_scan_fix/barcode_scan.dart';

import 'package:flutter/material.dart';
import 'package:my_library/Teacher/return_book.dart';
import '../student/home_screen_Student.dart';
import '../Services.dart';
import '../student/nav.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "IssuBook Local Server",
    home: IssuBook(),
  ));
}

class IssuBook extends StatefulWidget {
  @override
  _IssuBookState createState() => _IssuBookState();
  var name = _firstNameController.text;
}

String _titleProgress;
var _view=false;
var _firstNameController = TextEditingController();
var _lastNameController = TextEditingController();
var _firstNameController1 = TextEditingController();
var _firstNameController2 = TextEditingController();
var _borrowed = TextEditingController();
class _IssuBookState extends State<IssuBook> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  void initState() {
    super.initState();
    final String title = 'Flutter Data Table';
    var a = 0;
    _titleProgress = '';
      _view=false;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameController1 = TextEditingController();
    _firstNameController2 = TextEditingController();
  }
//////////////

////////

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }



  _verifyIssue(bino, adno) {
    Services.verifyIssue(bino,adno).then((result){
      if ('error'== result){
        _showAlert("Sorry"," Somting Wrong please try Again ",Icons.warning_amber_outlined);
        disableButton();
      }
      else if ('error'!= result){
        _showAlert("Done","Succesfully Issued",Icons.check_box);
        disableButton();
      }
    });
  }
  _IssuBook(a, b) {
    //_showProgress(a+b);

    Services.issueBook(a, b).then((result) {
      print (result);
      if ('        error' == result) {
       _showAlert("Error","Please ReScan",Icons.error_outlined);
        setState(() {
          _firstNameController.text = '';
          _lastNameController.text = '';
          disableButton();
        });
      } else if ((result == '        case1')) {
      _showAlert("Sorry","This text Is Booked by Someone",Icons.error_outlined);
        setState(() {
          _firstNameController.text = '';
          _lastNameController.text = '';
          disableButton();
        });
      } else if ('        case1' != result) {
        print(result);
        enableButton();
        var str = result;
        var parts = str.split(':');
        var prefix = parts[0].trim(); // prefix: "date"
        var afix =parts[1].trim();
        var borow = parts.sublist(2).join(':').trim();
        //_showProgress(prefix);
        setState(() {
          if(borow=='0'){
            _view=false;
          }
          else{
            _view=true;
          }
          _showProgress('');
          _firstNameController.text = prefix.toUpperCase();
          _lastNameController.text = afix.toUpperCase();
          _borrowed.text= borow;

        });
      }
    });
  }
  _showAlert(_title,_message,_icon){
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
                _firstNameController.text='';
                _firstNameController1.text='';
                _lastNameController.text='';
                _firstNameController2.text='';
                _view=false;
                _borrowed.text='';
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

  sampleFunction() {
    print('Clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Issue...",
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
                  visible: false,
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
                  visible: false,
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
                        labelText: "Scan Bar Code On Id Card",
                        labelStyle:
                            TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ),
                  //student id scan end here
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.amber, Colors.yellow]),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    readOnly: true,
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Title",
                      hintText: "Click button to scan Book code",
                      labelStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black),
                      suffixIcon: FloatingActionButton(
                        backgroundColor: Colors.amber[700],
                        onPressed: () async {
                          String codeSanner = await BarcodeScanner.scan();
                          _firstNameController.text = codeSanner;
                          _firstNameController1.text = codeSanner;
                        },
                        child: Icon(Icons.qr_code),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.amber, Colors.yellow]),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    readOnly: true,
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Student Name",
                      hintText: "click the button Scan ID card",
                      labelStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black),
                      suffixIcon: FloatingActionButton(
                        backgroundColor: Colors.amber[700],
                        onPressed: () async {
                          String codeSanner = await BarcodeScanner.scan();
                          _firstNameController2.text = codeSanner;
                          _IssuBook(_firstNameController1.text,
                              _firstNameController2.text);
                        },
                        child: Icon(Icons.qr_code),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
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
                      controller: _borrowed,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Books in Hand",
                        labelStyle:
                        TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ),
                  //student id scan end here
                ),
                SizedBox(
                  height: 30.0,
                ),

                RaisedButton(
                  onPressed: isEnabled ? () => _verifyIssue(_firstNameController1.text, _firstNameController2.text) : null,
                  color: Colors.amber[600],
                  textColor: Colors.black,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('Save'),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
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
