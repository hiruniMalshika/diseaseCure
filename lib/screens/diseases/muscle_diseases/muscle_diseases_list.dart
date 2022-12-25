import 'package:ctseproject/screens/diseases/muscle_diseases/add_new_muscle_disease.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

class MuscleDiseases extends StatefulWidget {
  const MuscleDiseases({Key? key}) : super(key: key);

  @override
  State<MuscleDiseases> createState() => _MuscleDiseasesState();
}

class _MuscleDiseasesState extends State<MuscleDiseases>{

  var _nameController = new TextEditingController();
  var _descriptionController = new TextEditingController();
  var _causesController = new TextEditingController();

  final textController = TextEditingController();
  CollectionReference diseases = FirebaseFirestore.instance.collection('muscles_diseases');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _descriptionController.text = documentSnapshot['description'].toString();
      _causesController.text = documentSnapshot['causes'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Decription',
                  ),
                ),
                TextField(
                  controller: _causesController,
                  decoration: const InputDecoration(
                    labelText: 'Causes',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final String? description =_descriptionController.text;
                    final String? causes =_causesController.text;

                    if (name != null && description != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await diseases.add({"name": name, "description": description, "causes": causes});
                      }

                      if (action == 'update') {
                        // Update the product
                        await diseases
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "description": description, "causes": causes});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _descriptionController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _info([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _descriptionController.text = documentSnapshot['description'].toString();
      _causesController.text = documentSnapshot['causes'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  maxLines:6,
                  minLines: 6,
                ),

                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Decription',
                  ),
                  maxLines:6,
                  minLines: 6,
                ),
                TextField(
                  controller: _causesController,
                  decoration: const InputDecoration(
                    labelText: 'Causes',
                  ),
                  maxLines:6,
                  minLines: 6,
                ),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //   child: Text(action == 'create' ? 'Create' : 'Update'),
                //   onPressed: () async {
                //     final String? name = _nameController.text;
                //     final String? description =_descriptionController.text;
                //     final String? causes =_causesController.text;
                //
                //     if (name != null && description != null) {
                //       if (action == 'create') {
                //         // Persist a new product to Firestore
                //         await diseases.add({"name": name, "description": description, "causes": causes});
                //       }
                //
                //       if (action == 'update') {
                //         // Update the product
                //         await diseases
                //             .doc(documentSnapshot!.id)
                //             .update({"name": name, "description": description, "causes": causes});
                //       }
                //
                //       // Clear the text fields
                //       _nameController.text = '';
                //       _descriptionController.text = '';
                //
                //       // Hide the bottom sheet
                //       Navigator.of(context).pop();
                //     }
                //   },
                // )
              ],
            ),
          );
        });
  }

  //delete function
  Future<void> _deleteProduct(String productId) async {
    await diseases.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a muscle disease')));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          width: double.infinity,

          //background image
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/wall.png'),
                //alignment: Alignment.topCenter,
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 65,
                    bottom: 15
                ),
                padding: const EdgeInsets.only(
                    left: kDefalutPadding,
                    right: kDefalutPadding
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //title - Lungs Diseases
                    Column(
                      children: const [
                        Text(
                          'Muscular Diseases',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF073484),
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNewMuscleDisease()
                            )
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //Display diseases List
              Expanded(child: SingleChildScrollView(
                child: Container(
                  height: 700,
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: StreamBuilder(
                    stream: diseases.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return const Center(child: Text('Loading'),);
                      }
                      else{
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                            return Container(
                              height: 72,
                              padding: const EdgeInsets.only(top: 15,),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 221,
                                    decoration: BoxDecoration(
                                      color: const Color(0x68FFFFFF),
                                      //shadowColor: Colors.black,
                                      //elevation: 10,
                                      borderRadius: BorderRadius.circular(29),
                                    ),

                                    child: ListTile(
                                      title: Text(
                                        documentSnapshot['name'],
                                        style: const TextStyle(
                                            fontSize: 23
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                //diseases.reference.delete();
                                                // _deleteProduct(documentSnapshot.id);

                                                showDialog(
                                                    context: context,
                                                    builder: (builder) => AlertDialog(
                                                        title: const Text('Confirm Your Deletion'),
                                                        content: const Text('Are you sure you want to delete this muscular disease.?'),
                                                        actions : [
                                                          TextButton(
                                                            onPressed: () {
                                                              _deleteProduct(documentSnapshot.id);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => const MuscleDiseases()
                                                                  )
                                                              );
                                                            },
                                                            child: const Text('Yes'),
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => const MuscleDiseases()
                                                                    )
                                                                );
                                                              },
                                                              child: const Text('No')
                                                          )
                                                        ]
                                                    )
                                                );
                                              },
                                              icon: const Icon(Icons.delete, color: Colors.red,)
                                          ),
                                          IconButton(
                                              onPressed: (){
                                                _createOrUpdate(documentSnapshot);
                                              },
                                              icon: const Icon(Icons.edit, color: Colors.blue,)
                                          ),
                                          IconButton(
                                              onPressed: (){
                                                _info(documentSnapshot);
                                              },
                                              icon: const Icon(Icons.info, color: Colors.blue,)
                                          ),
                                          /*IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.details)
                                )*/
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ))
            ],
          ),
        )
    );
  }
}



