import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({ Key? key }) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('problems');
  final _formKey = GlobalKey<FormState>();

  // text field state
  // String minAge = '';
  // String maxAge = '';
  // String civilStatus = '';
  // String jobStatus = '';
  // String problem = '';
  String error = '';

  final TextEditingController _minAge = TextEditingController();
  final TextEditingController _maxAge = TextEditingController();
  // final TextEditingController _civilStatus = TextEditingController();
  // final TextEditingController _jobStatus = TextEditingController();
  final TextEditingController _problem = TextEditingController();
  final listOfCivilStatus = ["married", "unmarried"];
  String civilStatusdropdownValue = 'married';
  final listOfJobStatus = ["employed", "unemployed"];
  String jobStatusdropdownValue = 'employed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[300],
        elevation: 0.0,
        title: Text('Add new Data'),
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 20.0,),
              // TextFormField(
              //   controller: _minAge,
              //   decoration: InputDecoration(
              //     hintText: 'Min Age'
              //   ),
              //   validator: (val) => val!.isEmpty ? 'Enter a minimum age' : null,
              // ),

              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _minAge,
                    decoration: InputDecoration(
                      labelText: "Enter Minimum Age",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a minimum age';
                      }
                      return null;
                    },
                  ),
                ),


              // SizedBox(height: 20.0,),
              // TextFormField(
              //   controller: _maxAge,
              //   decoration: InputDecoration(
              //     hintText: 'Max Age'
              //   ),
              //   validator: (val) => val!.isEmpty ? 'Enter a maximum age' : null,
              //   // onChanged: (val) {
              //   //   setState(() {
              //   //     maxAge = val;
              //   //   });
              //   // },
              // ),

              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _maxAge,
                    decoration: InputDecoration(
                      labelText: "Enter Maximum Age",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a maximum age';
                      }
                      return null;
                    },
                  ),
                ),

              // SizedBox(height: 20.0,),
              // TextFormField(
              //   controller: _civilStatus,
              //   decoration: InputDecoration(
              //     hintText: 'Civil Status'
              //   ),
              //   validator: (val) => val!.isEmpty ? 'Enter the civil status' : null,
              //   // onChanged: (val) {
              //   //   setState(() {
              //   //     civilStatus = val;
              //   //   });
              //   // },
              // ),

              // Padding(
              //     padding: EdgeInsets.all(20.0),
              //     child: TextFormField(
              //       controller: _civilStatus,
              //       decoration: InputDecoration(
              //         labelText: "Enter Civil Status",
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //       ),
              //       // The validator receives the text that the user has entered.
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'Enter the civil status';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),

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
                      fillColor: Colors.white,
                      filled: true,
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


              // SizedBox(height: 20.0,),
              // TextFormField(
              //   controller: _jobStatus,
              //   decoration: InputDecoration(
              //     hintText: 'Job Status'
              //   ),
              //   validator: (val) => val!.isEmpty ? 'Enter the job status' : null,
              //   // onChanged: (val) {
              //   //   setState(() {
              //   //     jobStatus = val;
              //   //   });
              //   // },
              // ),

              // Padding(
              //     padding: EdgeInsets.all(20.0),
              //     child: TextFormField(
              //       controller: _jobStatus,
              //       decoration: InputDecoration(
              //         labelText: "Enter Job Status",
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //       ),
              //       // The validator receives the text that the user has entered.
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return 'Enter the job status';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),

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
                      fillColor: Colors.white,
                      filled: true,
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


              // SizedBox(height: 20.0,),
              // TextFormField(
              //   controller: _problem,
              //   decoration: InputDecoration(
              //     hintText: 'Problem'
              //   ),
              //   validator: (val) => val!.isEmpty ? 'Enter the problem' : null,
              //   // onChanged: (val) {
              //   //   setState(() {
              //   //     problem = val;
              //   //   });
              //   // },
              // ),

              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _problem,
                    decoration: InputDecoration(
                      labelText: "Enter Problem",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the problem';
                      }
                      return null;
                    },
                  ),
                ),


              // SizedBox(height: 70.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var arrAge = [];
                    for (var i = 0; i < ((int.parse(_maxAge.text) + 1)-int.parse(_minAge.text)); i++) {
                      arrAge.add(int.parse(_minAge.text) + i);
                    }
                    await collectionReference.add({
                      'age': arrAge,
                      // 'maxAge': int.parse(_maxAge.text),
                      'civilStatus': civilStatusdropdownValue,
                      'jobStatus': jobStatusdropdownValue,
                      'problem': _problem.text
                    }).then((value) => {
                      _minAge.clear(),
                      _maxAge.clear(),
                      civilStatusdropdownValue = 'married',
                      jobStatusdropdownValue = 'employed',
                      _problem.clear(),
                      showDialog(context: context, builder: (context) => CustomDialog(
                      title: 'SUCCESS', 
                      description: 'Successfully saved.', 
                      buttonText: 'OK'))
                    });
                  }
                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 80.0,),
            ],
          ),
        ),
      ),),
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
            backgroundImage: AssetImage('assets/success.gif'),
          ),
        )
      ],
    );
  }
}