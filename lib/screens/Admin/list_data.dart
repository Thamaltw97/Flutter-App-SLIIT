import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  const ListData({ Key? key }) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {

  final scaffoldState = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController? _minAge = TextEditingController();
  final TextEditingController? _maxAge = TextEditingController();
  final TextEditingController? _problem = TextEditingController();
  final listOfCivilStatus = ["married", "unmarried"];
  String civilStatusdropdownValue = 'married';
  final listOfJobStatus = ["employed", "unemployed"];
  String jobStatusdropdownValue = 'employed';

  void _showSettingsPanel(data) {
    setState(() {
      civilStatusdropdownValue = data['civilStatus'];
      jobStatusdropdownValue = data['jobStatus'];
      _minAge!.text = data['age'][0].toString();
      _maxAge!.text = (data['age'][0] + (data['age'].length - 1)).toString();
      _problem!.text = data['problem'];
    });
    scaffoldState.currentState!.showBottomSheet((context) {
      return Container(
        color: Colors.blue[50],
        height: 660,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update / Delete the problems',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _minAge,
                decoration: InputDecoration(
                  hintText: 'Min Age',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _maxAge,
                decoration: InputDecoration(
                  hintText: 'Max Age',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                ),
                value: civilStatusdropdownValue,
                icon: Icon(Icons.arrow_downward),
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
              SizedBox(height: 20.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                ),
                value: jobStatusdropdownValue,
                icon: Icon(Icons.arrow_downward),
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
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _problem,
                decoration: InputDecoration(
                  hintText: 'Problem',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20.0,),
              Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var arrAge = [];
                        for (var i = 0; i < ((int.parse(_maxAge!.text) + 1)-int.parse(_minAge!.text)); i++) {
                          arrAge.add(int.parse(_minAge!.text) + i);
                        }
                        await collectionReference.doc(data.id).update({
                          'age': arrAge,
                          'civilStatus': civilStatusdropdownValue,
                          'jobStatus': jobStatusdropdownValue,
                          'problem': _problem!.text
                        }).then((value) => {
                          _minAge!.clear(),
                          _maxAge!.clear(),
                          civilStatusdropdownValue = 'married',
                          jobStatusdropdownValue = 'employed',
                          _problem!.clear(),
                          Navigator.pop(context),
                          showDialog(context: context, builder: (context) => CustomDialog(
                          title: 'SUCCESS', 
                          description: 'Successfully updated.', 
                          buttonText: 'OK'))
                        }).onError((error, stackTrace) => {
                        
                        });
                        
                      }
                    },
                  ),
                  SizedBox(width: 20.0,),
                  RaisedButton(
                    color: Colors.red[600],
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await collectionReference.doc(data.id).delete()
                      .then((value) => {
                        _minAge!.clear(),
                          _maxAge!.clear(),
                          civilStatusdropdownValue = 'married',
                          jobStatusdropdownValue = 'employed',
                          _problem!.clear(),
                          Navigator.pop(context),
                          showDialog(context: context, builder: (context) => CustomDialog(
                          title: 'SUCCESS', 
                          description: 'Successfully deleted.', 
                          buttonText: 'OK'))
                      }).onError((error, stackTrace) => {

                      });
                      // if (_formKey.currentState!.validate()) {
                      //   var arrAge = [];
                      //   for (var i = 0; i < ((int.parse(_maxAge!.text) + 1)-int.parse(_minAge!.text)); i++) {
                      //     arrAge.add(int.parse(_minAge!.text) + i);
                      //   }
                      //   await collectionReference.doc(data.id).update({
                      //     'age': arrAge,
                      //     'civilStatus': civilStatusdropdownValue,
                      //     'jobStatus': jobStatusdropdownValue,
                      //     'problem': _problem!.text
                      //   }).then((value) => {
                      //     _minAge!.clear(),
                      //     _maxAge!.clear(),
                      //     civilStatusdropdownValue = 'married',
                      //     jobStatusdropdownValue = 'employed',
                      //     _problem!.clear(),
                      //     Navigator.pop(context),
                      //     showDialog(context: context, builder: (context) => CustomDialog(
                      //     title: 'SUCCESS', 
                      //     description: 'Successfully updated.', 
                      //     buttonText: 'OK'))
                      //   });
                        
                      // }
                    },
                  ),
                ],
              ),
              
            ],
          ),
        )
      );
    });
  }

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('problems');
  //final dbRef = FirebaseFirestore.instance.reference().child("problems");
  // Map dataSet = {};
  
  // collectionReference.snapshots().listen((event) {
    
  // })

  // fetchData() {
  //   final CollectionReference collectionReference = FirebaseFirestore.instance.collection('problems');
  //   collectionReference.snapshots().listen((event) {
      
  //     // List documents;
  //     dataSet = event.docs;

  //   })
  // }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[300],
        elevation: 0.0,
        title: Text('List of Problems'),
      ),
      backgroundColor: Colors.blueGrey[100],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                  stream: collectionReference.snapshots(),  // collectionReference.where('minAge', isEqualTo: 18).where('civilStatus', isEqualTo: 'unmarried').snapshots()
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // return ProblemTile(problem: snapshot.data!.docs[index]);
                        return Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Card(
                            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                            child: ListTile(
                              leading: Icon(Icons.keyboard_arrow_right),
                              title: Text(snapshot.data!.docs[index]['problem']),
                              subtitle: Text('Age range: ${snapshot.data!.docs[index]['age'][0]}-${snapshot.data!.docs[index]['age'][0] + snapshot.data!.docs[index]['age'].length - 1} | ${snapshot.data!.docs[index]['civilStatus']} | ${snapshot.data!.docs[index]['jobStatus']}'),
                              onTap: () => _showSettingsPanel(snapshot.data!.docs[index]),
                            ),
                          ),
                        );
                      }
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                  },

            ))
          ],
        ),
      ),
    );
  }
}

// class ProblemTile extends StatelessWidget {

//   final
//   const ProblemTile({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

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