import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewSkinDisease extends StatefulWidget {
  static String routeName = '/addskindisease';
  const AddNewSkinDisease({Key? key}) : super(key: key);

  @override
  State<AddNewSkinDisease> createState() => _AddNewSkinDiseaseState();
}

class _AddNewSkinDiseaseState extends State<AddNewSkinDisease> {
  // text fields' controllers
 final nameController =  TextEditingController();
 final descriptionController = TextEditingController();
 final causesController = TextEditingController();

  CollectionReference _skindiseases = FirebaseFirestore.instance.collection('skin_diseases');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product




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
                image: AssetImage("assets/images/newwp.jpg"),
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
                          'ADD NEW SKIN DISEASE',
                          style: GoogleFonts.italiana(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,


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
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Disease name',
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
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Description',
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
                              controller: causesController,
                              decoration: const InputDecoration(
                                labelText: 'Causes',
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
                    OutlinedButton(
                        onPressed:() {
                          _skindiseases.add({
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'causes': causesController.text
                          });
                          nameController.clear();
                          descriptionController.clear();
                          causesController.clear();
                        },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        )
                      ),
                    )

                  ],
                )
              ],
            ),


          ),
        )
    );
  }
}
