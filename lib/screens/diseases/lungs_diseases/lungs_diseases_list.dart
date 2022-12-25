import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LungsDiseases extends StatefulWidget {
  const LungsDiseases({Key? key}) : super(key: key);

  @override
  State<LungsDiseases> createState() => _LungsDiseasesState();
}

class _LungsDiseasesState extends State<LungsDiseases> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference diseases = FirebaseFirestore.instance.collection('diseases');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          title: TextField(
            controller: textController,
          ),
        ),
        body: Center(
          child: StreamBuilder(
            stream: diseases.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(child: Text('Loading'),);
              }
              return ListView(
                children: snapshot.data!.docs.map((disease){
                  return Center(
                    child: ListTile(
                      title: Text(disease['name']),
                      onLongPress: (){
                        disease.reference.delete();
                      },
                    ),
                  );
                }).toList(),
              );
            },

          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
            diseases.add({
              'name': textController.text,

            });
            textController.clear();
          },
        ),
      ),
    );
  }
}
