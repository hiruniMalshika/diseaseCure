import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseproject/constants.dart';
import 'package:ctseproject/screens/diseases/skin_diseases/add_new_skin_disease.dart';
import 'package:ctseproject/screens/diseases/skin_diseases/view_skin_disease.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkinDiseaseList extends StatefulWidget {
  static String routeName = '/addskindiseaseSkin';
  const SkinDiseaseList({Key? key}) : super(key: key);

  @override
  State<SkinDiseaseList> createState() => _SkinDiseaseListState();
}

class _SkinDiseaseListState extends State<SkinDiseaseList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _causesController = TextEditingController();

  CollectionReference _skindiseases = FirebaseFirestore.instance.collection('skin_diseases');

  Future<void> _singleDiseaseView([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _descriptionController.text = documentSnapshot['description'];
      _causesController.text = documentSnapshot['causes'];
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
                const Text(
                  'Full information',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Decription',
                  ),
                  maxLines: 7,
                  minLines: 7,
                ),
                TextField(
                  controller: _causesController,
                  decoration: const InputDecoration(labelText: 'Causes'),
                  maxLines: 7,
                  minLines: 7,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _descriptionController.text = documentSnapshot['description'];
      _causesController.text = documentSnapshot['causes'];
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
                  maxLines: 7,
                  minLines: 7,
                ),
                TextField(
                  controller: _causesController,
                  decoration: const InputDecoration(labelText: 'Causes'),
                  maxLines: 7,
                  minLines: 7,
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
                        await _skindiseases.add({"name": name, "description": description, "causes": causes});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _skindiseases
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

  Future<void> _deleteProduct(String productId) async {
    await _skindiseases.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a skin disease')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin diseases'),
      ),
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/skinwallpaper01.jpg"),//assets/images/wp01.jpg
              scale: 1,
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 15),
              padding: const EdgeInsets.only(
                left: kDefalutPadding,
                right: kDefalutPadding
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AddNewSkinDisease.routeName);
                    },
                    child: Container(
                      width: 200,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'ADD SKIN DISEASE',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple
                      ),
                    ),
                  )
                ],
              ),
            ),

            //display skin diseases
            Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: _skindiseases.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['name'],
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontSize: 23,
                            ),),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                // Press this button to edit a single product
                                IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.deepPurple,),
                                    onPressed: () =>
                                        _createOrUpdate(documentSnapshot)
                                ),
                                // This icon button is used to delete a single product
                                IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red,),
                                    onPressed: () => {
                                      showDialog(
                                        context: context,
                                        builder: (builder) => AlertDialog(
                                          title: const Text("Delete Anyway?"),
                                          content: const Text('Do you really want to delete?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                _deleteProduct(documentSnapshot.id);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const SkinDiseaseList()
                                                  )
                                                );
                                              },
                                              child: Text('Yes')
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const SkinDiseaseList()
                                                  )
                                                );
                                              },
                                              child: Text('No')
                                            )
                                        ],
                                        )
                                      )
                                    }
                                ),
                                IconButton(
                                    icon: const Icon(Icons.info, color: Colors.green,),
                                    onPressed: () =>
                                        _singleDiseaseView(documentSnapshot)
                                ),//_deleteProduct(documentSnapshot.id)),

                              ],

                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewSkinDisease(documentSnapshot: documentSnapshot),
                              ),
                            );
                          }
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
                )
            )
          ],
        ),
      ),
    );
  }
}
