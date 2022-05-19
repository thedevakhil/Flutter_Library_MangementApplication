
import 'package:flutter/material.dart';
import 'package:my_library/Admins/admin%20home.dart';
import 'package:my_library/Teacher/admin_home_Nav.dart';
import 'student/nav.dart';
import 'Services.dart';
import 'Teacher/adhome.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Local Server",
    home: Login(),
  ));
}


class Login extends StatefulWidget {
  @override

  _LoginState createState() => _LoginState();
  var name=_firstNameController.text;

}
String _titleProgress;
int selectedRadio = 1;
var _firstNameController = TextEditingController();
var _lastNameController = TextEditingController();
class _LoginState extends State<Login> {

  GlobalKey<ScaffoldState> _scaffoldKey;
  void initState() {
    super.initState();
    final String title = 'Flutter Data Table';
    _titleProgress = '';
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

  }
//////////////

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
////////

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _login2() {

    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      _showProgress( "Empty Fields");
      print('Empty Fields');
      return;
    }
    _showProgress('Please Wait For A while!');
    Services.login2(_firstNameController.text, _lastNameController.text,selectedRadio.toString())
        .then((result) {
      if ('Admin' == result.trimLeft()) {
        runApp(
         Adhome(),
         );
      }
      else if('Teacher' == result.trimLeft()) {
        print(result);
        runApp(
          Adnav(),
        );
      }
      else if('Student'== result.trimLeft()){
        runApp(
          Nav(),
        );
      }
      else{
        _showAlert("Sorry", "User name or Email is Incorrect", Icons.info_outline);
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
                _lastNameController.text='';
               _showProgress('');
              });
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text("Welcome",style: TextStyle(
      color: Colors.black),),
          backgroundColor: Colors.amber,
          elevation: 0.5,
          actions: <Widget>[
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/a.jpg'),
              fit: BoxFit.cover,

            )
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[

                    Radio(
                      activeColor: Colors.orange,
                      groupValue: selectedRadio,

                      value: 1,
                      onChanged: (val) {
                        print(val);
                        setSelectedRadio(val);
                      },
                    ),
                    Text('Student',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Radio(
                      activeColor: Colors.black,
                      groupValue: selectedRadio,
                      value: 2,

                      onChanged: (val) {
                        print(val);
                        setSelectedRadio(val);
                      },
                    ),
                    Text('Teacher',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),


                  ],
                ),
                SizedBox(
                  height: 25.0,

                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      gradient:
                      LinearGradient(colors: [Colors.amber, Colors.yellow]),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    controller:  _firstNameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Username",
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
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
                    controller: _lastNameController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    ),
                  ),

                SizedBox(
                  height: 30.0,

                ),

                GestureDetector(
                  onTap: () {
                    _login2();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        (Colors.orange),
                        Colors.amber
                      ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight
                      ),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(_titleProgress,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      )
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
/////bottom code

              /////bottom code end here

              ],
            ),

          ),
        ));
  }
}