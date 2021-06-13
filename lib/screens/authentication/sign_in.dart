// import 'package:brew_crew_firebase/screens/auth/register.dart';
// import 'package:brew_crew_firebase/screens/home/home.dart';
// import 'package:brew_crew_firebase/services/auth.dart';
import 'package:ctse_flutter_app/screens/Admin/admin_panel.dart';
import 'package:ctse_flutter_app/screens/services/auth.dart';
import 'package:ctse_flutter_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  
  //final Function toggleView;
  //SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  static final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[300],
        elevation: 0.0,
        title: Text('Sign in as Admin'),
        // actions: <Widget>[
        //   FlatButton.icon(onPressed: () {
        //     //widget.toggleView();
        //     Navigator.pop(context);
        //     Navigator.push(context, new MaterialPageRoute(
        //       builder: (context) => Register()
        //     ));
        //   }, icon: Icon(Icons.person), label: Text('Register'))
        // ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //print('Valid');
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please enter valid credentials';
                        loading = false;
                      });
                    } else {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => AdminPanel()
                      ));
                    }
                  }
                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )
      ),
    );
  }
}