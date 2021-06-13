import 'package:ctse_flutter_app/screens/authentication/sign_in.dart';
import 'package:ctse_flutter_app/screens/home/problem_find.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Life Problems'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Admin'),
              onPressed: () async {
                // await _auth.signOut();
                // Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => SignIn()
                ));
              },
            ),
          ],
        ),
        // body: Scaffold(
        //   body: RaisedButton.icon(onPressed: () {
        //     Navigator.push(context, new MaterialPageRoute(
        //       builder: (context) => ProblemFind()
        //     ));
        //   }, 
        //   icon: Icon(Icons.arrow_forward), label: Text('Get Started')),
        //   // Image.asset('assets/question2.png')
        //         // Center(
        //         //   child: CircleAvatar(
        //         //     backgroundImage: AssetImage('question.png'),
        //         //     radius: 40,
        //         //   ),
        //         // ),
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(145, 131, 222, 1),
                Color.fromRGBO(160, 148, 227, 1),
                Color.fromRGBO(180, 165, 227, 1),
                Color.fromRGBO(220, 182, 227, 1),
              ], 
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: topPadding,),
                  SizedBox(height: 10.0,),
                  AnimatedImage(),
                  SizedBox(height: 200.0,),
                  // ignore: deprecated_member_use
                  RaisedButton.icon(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => ProblemFind()
                      ));
                    }, 
                    icon: Icon(Icons.arrow_forward), label: Text('Get Started'),
                    textColor: Colors.white,
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    color: Colors.indigo[400],
                  ),
                // Center(
                //   child: CircleAvatar(
                //     backgroundImage: AssetImage('question.png'),
                //     radius: 40,
                //   ),
                // ),
                ],
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({ Key? key }) : super(key: key);

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(vsync: this, 
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);
  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.12),
  ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset('assets/q2_edited.png',width: 350),
    );
  }
}