import 'package:ctse_flutter_app/screens/Admin/add_data.dart';
import 'package:ctse_flutter_app/screens/Admin/list_data.dart';
import 'package:ctse_flutter_app/screens/home/home.dart';
import 'package:ctse_flutter_app/screens/services/auth.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
          title: Text('Admin Panel'),
          backgroundColor: Colors.blueAccent[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign out'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => Home()
                ));
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0,),
              // RaisedButton.icon(onPressed: () {
              //   Navigator.push(context, new MaterialPageRoute(
              //     builder: (context) => AddData()
              //   ));
              // }, icon: Icon(Icons.arrow_forward), label: Text('Add Data')),
              
              RaisedButton.icon(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => AddData()
                  ));
                }, 
                icon: Icon(Icons.arrow_forward), label: Text('Add Data'),
                textColor: Colors.white,
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                color: Colors.indigo[400],
              ),

              SizedBox(height: 50.0,),
              // RaisedButton.icon(onPressed: () {
              //   Navigator.push(context, new MaterialPageRoute(
              //     builder: (context) => ListData()
              //   ));
              // }, icon: Icon(Icons.arrow_back), label: Text('Fetch Data')),

              RaisedButton.icon(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => ListData()
                  ));
                }, 
                icon: Icon(Icons.arrow_forward), label: Text('Fetch Data'),
                textColor: Colors.white,
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                color: Colors.indigo[400],
              ),
            ],
          ),
        ),
      // child: Scaffold(
      //   backgroundColor: Colors.brown[50],
      //   ,
      //   body: Scaffold(
      //     ch
      //     // child: RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.arrow_forward), label: Text('Add Data')),
      //     // SizedBox(height: 20.0,),
      //   ),
      );
  }
}