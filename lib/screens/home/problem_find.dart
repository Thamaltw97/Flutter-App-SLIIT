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
  final TextEditingController _civilStatus = TextEditingController();
  final TextEditingController _jobStatus = TextEditingController();
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

                // Padding(
                // padding: EdgeInsets.all(20.0),
                //   child: TextFormField(
                //     controller: _civilStatus,
                //     decoration: InputDecoration(
                //       labelText: "Enter Civil Status",
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //     ),
                //     // The validator receives the text that the user has entered.
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Enter Civil Status';
                //       }
                //       return null;
                //     },
                //   ),
                // ),

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
                child: ElevatedButton(
                    onPressed: () {
                      Problems problems = new Problems(age: _age.text, civilStatus: civilStatusdropdownValue, jobStatus: jobStatusdropdownValue);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProblemView(problems: problems)),
                      );
                    },
                    child: Text('Find your problems'),
                  ),
                ),
                SizedBox(height: 180.0,),

          

              // SizedBox(height: 10.0,),
              // Row(
              //   children: <Widget>[
              //     new Flexible(
              //     child: new TextFormField(
              //         controller: _age,
              //         decoration: InputDecoration(
              //           hintText: 'Age'
              //         ),
              //         validator: (val) => val!.isEmpty ? 'Required' : null,
              //       ),
              //     ),
              //     new Flexible(
              //     child: new TextFormField(
              //         controller: _civilStatus,
              //         decoration: InputDecoration(
              //           hintText: 'Civil status'
              //         ),
              //         validator: (val) => val!.isEmpty ? 'Required' : null,
              //       ),
              //     ),
              //     new Flexible(
              //     child: new TextFormField(
              //         controller: _jobStatus,
              //         decoration: InputDecoration(
              //           hintText: 'Job status'
              //         ),
              //         validator: (val) => val!.isEmpty ? 'Required' : null,
              //       ),
              //     ),
              //   ],
              // ),

              // Row(
              //   children: <Widget>[
              //     RaisedButton(
              //       color: Colors.pink[400],
              //       child: Text(
              //         'Search',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {

              //       },
              //     )
              //   ],
              // ),


              
            //   Expanded(
            //     child: StreamBuilder(
            //       stream: collectionReference.snapshots(),  // collectionReference.where('minAge', isEqualTo: 18).where('civilStatus', isEqualTo: 'unmarried').snapshots()
            //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if(snapshot.hasData){
            //         return ListView.builder(
            //           itemCount: snapshot.data!.docs.length,
            //           itemBuilder: (context, index) {
            //             return Padding(
            //               padding: EdgeInsets.only(top: 0.0),
            //               child: Card(
            //                 margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            //                 child: ListTile(
            //                   leading: Icon(Icons.keyboard_arrow_right),
            //                   title: Text(snapshot.data!.docs[index]['problem']),
            //                   // subtitle: Text('Age range: ${snapshot.data!.docs[index]['minAge']}-${snapshot.data!.docs[index]['maxAge']} | ${snapshot.data!.docs[index]['civilStatus']} | ${snapshot.data!.docs[index]['jobStatus']}'),

            //                 ),
            //               ),
            //             );
            //           }
            //         );
            //       }
            //       return Center(child: CircularProgressIndicator(),);
            //       },

            // ))
              
            ],
          ),
        )
      ),
    );
  }
}