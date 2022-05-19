import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Teacher/issubook.dart';
import '../Teacher/return_book.dart';
import '../Services.dart';
import '../login.dart';
import '../Student.dart';
void main() => runApp(ViewAllIssued());

class ViewAllIssued extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Container(
            child:  Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
                Text('ISSUED BOOKS'),

              ],
            ),
          ),
        ),
        body: JsonListView(),
      ),
    );
  }
}
var a=Login().name;


class JsonListView extends StatefulWidget {

  JsonListViewWidget createState() => JsonListViewWidget();

}

class JsonListViewWidget extends State<JsonListView> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: Services.viewallissuedadmin(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) return Center(
          //child: CircularProgressIndicator()
          child: Text("No Bookings"),
        );

        return
          ListView(

            children:  snapshot.data
                .map((data) =>ListTile(
              //key: cardB,
              leading: Column(children: <Widget>[SizedBox(height: 8,),Icon(Icons.person,color: Colors.amber,),Text(data.adno),

              ]),
              title: Text(data.firstName.toUpperCase(),style: TextStyle(color: Colors.yellow[800], fontSize: 13,fontWeight: FontWeight.bold)),

              subtitle: Text(data.lastName.toUpperCase()),

              trailing:Icon(Icons.arrow_forward),
              onTap: () {
                // This Will Call When User Click On ListView Item
                showDialogFunc(context,data.firstName, data.lastName.toUpperCase(), data.edition, data.bino, data.status,data.rate,data.category,data.name,data.isd);

              },


            ),
            )
                .toList(),
          );

      },
    );
  }
}


showDialogFunc(context,title, author, edition, isd,status,rate,category,name,date) {
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
            height: 400,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,

                      child: Image.asset('images/b.jpg',height: 50,),
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
                  'CATEGORY: '+category,
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
                  'Issued On: '+date,
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
                  'Issued For: '+name.toString().toUpperCase(),
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
                Container(
                  //width: 100,
                  height: 40,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.network(
                      'https://cdn.shoplightspeed.com/shops/626275/files/18687152/600x600x1/stickers-northwest-sticker-smiley-face.jpg',height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

_showAlert(context,_title,_message,_icon){
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(_title),
      content: Text(_message),
      actions: <Widget>[
        FlatButton(
          onPressed: () {

            //runApp(MyApp());
          },
          child: Icon(_icon),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(ctx).pop();

          },
          child: Icon(Icons.cancel_outlined),
        ),
      ],
    ),
  );
}