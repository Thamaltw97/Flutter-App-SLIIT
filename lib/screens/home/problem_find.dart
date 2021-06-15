import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse_flutter_app/models/problems.dart';
import 'package:ctse_flutter_app/screens/home/problem_view.dart';
import 'package:flutter/material.dart';

class ProblemFind extends StatefulWidget {
  const ProblemFind({ Key? key }) : super(key: key);

  @override
  _ProblemFindState createState() => _ProblemFindState();
}

class _ProblemFindState extends State<ProblemFind> {

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('problems');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _age = TextEditingController();
  // final TextEditingController _civilStatus = TextEditingController();
  // final TextEditingController _jobStatus = TextEditingController();
  final listOfCivilStatus = ["married", "unmarried"];
  String civilStatusdropdownValue = 'married';
  final listOfJobStatus = ["employed", "unemployed"];
  String jobStatusdropdownValue = 'employed';

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Seek Future Problems'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              SizedBox(height: 50.0,),

              Text("Please enter your details",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic)),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _age,
                    decoration: InputDecoration(
                      labelText: "Enter Age",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Age';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: DropdownButtonFormField(
                    value: civilStatusdropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    decoration: InputDecoration(
                      labelText: "Select Civil Status",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    items: listOfCivilStatus.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        civilStatusdropdownValue = newValue.toString();
                      });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: DropdownButtonFormField(
                    value: jobStatusdropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    decoration: InputDecoration(
                      labelText: "Select Job Status",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    items: listOfJobStatus.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        jobStatusdropdownValue = newValue.toString();
                      });
                    },
                  ),
                ),

                Padding(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 42),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      if (int.parse(_age.text) > 100) {
                        showDialog(context: context, builder: (context) => CustomDialog(
                        title: 'ERROR', 
                        description: 'Please enter valid age.', 
                        buttonText: 'OK'));
                      } else {
                        Problems problems = new Problems(
                          age: _age.text, 
                          civilStatus: civilStatusdropdownValue, 
                          jobStatus: jobStatusdropdownValue
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProblemView(problems: problems)),
                        );
                      }
                        
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text('Find your problems'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 180.0,),

            ],
          ),
        )
      ),
    );
  }
}


// Alert dialog
class CustomDialog extends StatelessWidget {

  final String title, description, buttonText;
  // final Image image;

  const CustomDialog({ required this.title, required this.description, required this.buttonText });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                description, style: TextStyle(
                  fontSize: 16.0
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(onPressed: () {
                  Navigator.pop(context);
                }, 
                child: Text('OK')),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 50,
            backgroundImage: AssetImage('assets/failed.gif'),
          ),
        )
      ],
    );
  }
}