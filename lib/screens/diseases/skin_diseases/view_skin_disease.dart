import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewSkinDisease extends StatefulWidget {
  const ViewSkinDisease({Key? key, required this.documentSnapshot}) : super(key: key);




  final DocumentSnapshot documentSnapshot;
  @override
  State<ViewSkinDisease> createState() => _ViewSkinDiseaseState();
}

class _ViewSkinDiseaseState extends State<ViewSkinDisease> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _causesController = TextEditingController();
  CollectionReference _skindiseases = FirebaseFirestore.instance.collection('skin_diseases');

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

              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: Container(
          width: double.infinity,

          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wp02.jpeg"),
                //assets/images/wp01.jpg
                alignment: Alignment.topCenter,
                fit: BoxFit.cover
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 210.0, bottom: 20.0),
                        child: Text(
                          'View Skin Disease',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff0C2551),
                              fontWeight: FontWeight.w900
                          ),
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: SizedBox(
                            height: 50,
                            width: 370,
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(

                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              ),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 15,),
                    Container(
                        child: Center(
                          child: SizedBox(
                            width: 370,
                            child: TextFormField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              ),
                              maxLines: 4,
                              minLines: 4,
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 15,),
                    Container(
                        child: Center(
                          child: SizedBox(
                            width: 370,
                            child: TextFormField(
                              controller: _causesController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              ),
                              maxLines: 4,
                              minLines: 4,
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 15,),

                  ],
                )
              ],
            ),


          ),
        )
    );
  }
}
