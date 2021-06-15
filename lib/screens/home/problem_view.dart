import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse_flutter_app/models/problems.dart';
import 'package:flutter/material.dart';

class ProblemView extends StatelessWidget {
  // const ProblemView({ Key? key }) : super(key: key);
  
  final Problems problems;
  const ProblemView({Key? key, required this.problems}) : super(key: key);
  static final CollectionReference collectionReference = FirebaseFirestore.instance.collection('problems');
  static bool isPrinted = false;
  static var dataSet = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Seek Future Problems'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: StreamBuilder(
                  stream: collectionReference
                            .where('age', arrayContains: int.parse(this.problems.age))
                            // .where('maxAge', isGreaterThanOrEqualTo: int.parse(this.problems.age))
                            .where('civilStatus', isEqualTo: this.problems.civilStatus)
                            .where('jobStatus', isEqualTo: this.problems.jobStatus)
                            .snapshots(),  // collectionReference.where('minAge', isEqualTo: 18).where('civilStatus', isEqualTo: 'unmarried').snapshots()
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    isPrinted = true;

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        dataSet.add(snapshot.data!.docs[index]);
                        return Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Card(
                            margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: ListTile(
                              leading: Icon(Icons.keyboard_arrow_right),
                              title: Text(snapshot.data!.docs[index]['problem']),
                              // subtitle: Text('Age range: ${snapshot.data!.docs[index]['minAge']}-${snapshot.data!.docs[index]['maxAge']} | ${snapshot.data!.docs[index]['civilStatus']} | ${snapshot.data!.docs[index]['jobStatus']}'),
                            ),
                          ),
                        );
                      }
                    );
                  } else if (isPrinted) {

                      return ListView.builder(
                        itemCount: dataSet.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Card(
                              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                              child: ListTile(
                                leading: Icon(Icons.keyboard_arrow_right),
                                title: Text(dataSet[index]['problem']),
                                // subtitle: Text('Age range: ${snapshot.data!.docs[index]['minAge']}-${snapshot.data!.docs[index]['maxAge']} | ${snapshot.data!.docs[index]['civilStatus']} | ${snapshot.data!.docs[index]['jobStatus']}'),
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



// class ProblemView extends StatefulWidget {
//   const ProblemView({ Key? key }) : super(key: key);

//   @override
//   _ProblemViewState createState() => _ProblemViewState();
// }

// class _ProblemViewState extends State<ProblemView> {

//   final CollectionReference collectionReference = FirebaseFirestore.instance.collection('problems');
//   // final Problems problems;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue[400],
//         elevation: 0.0,
//         title: Text('Seek Future Problems'),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//         child: (
//           Expanded(
//                 child: StreamBuilder(
//                   stream: collectionReference.snapshots(),  // collectionReference.where('minAge', isEqualTo: 18).where('civilStatus', isEqualTo: 'unmarried').snapshots()
//                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if(snapshot.hasData){
//                     return ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: EdgeInsets.only(top: 0.0),
//                           child: Card(
//                             margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//                             child: ListTile(
//                               leading: Icon(Icons.keyboard_arrow_right),
//                               title: Text(snapshot.data!.docs[index]['problem']),
//                               // subtitle: Text('Age range: ${snapshot.data!.docs[index]['minAge']}-${snapshot.data!.docs[index]['maxAge']} | ${snapshot.data!.docs[index]['civilStatus']} | ${snapshot.data!.docs[index]['jobStatus']}'),

//                             ),
//                           ),
//                         );
//                       }
//                     );
//                   }
//                   return Center(child: CircularProgressIndicator(),);
//                   },

//             ))
//         ),
//       ),
//     );
//   }
// }