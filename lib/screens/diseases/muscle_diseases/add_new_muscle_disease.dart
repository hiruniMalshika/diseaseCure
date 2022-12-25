import 'package:ctseproject/screens/diseases/muscle_diseases/muscle_diseases_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewMuscleDisease extends StatefulWidget {
  const AddNewMuscleDisease({Key? key}) : super(key: key);

  @override
  State<AddNewMuscleDisease> createState() => _AddNewMuscleDiseaseState();
}

class _AddNewMuscleDiseaseState extends State<AddNewMuscleDisease> {

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _causesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference diseases = FirebaseFirestore.instance.collection('muscles_diseases');

    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/shape01.jpeg'),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 210.0, bottom: 20.0),
                      child: Text(
                        'Add New Muscular Disease',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color(0xff0C2551),
                            fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: SizedBox(
                            height: 50,
                            width: 370,
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Disease Name',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                                labelText: 'Description',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                                labelText: 'Causes',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              ),
                              maxLines: 4,
                              minLines: 4,
                            ),
                          ),
                        )
                    ),

                    const SizedBox(height: 30,),

                    OutlinedButton(
                      onPressed: () {
                        diseases.add({
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                          'causes': _causesController.text
                        });
                        _nameController.clear();
                        _descriptionController.clear();
                        _causesController.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MuscleDiseases()
                            )
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
                          )
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            )
                        ),
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
