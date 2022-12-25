import 'package:ctseproject/constants.dart';
import 'package:ctseproject/screens/diseases/lungs_diseases/lungs_diseases_list.dart';
import 'package:ctseproject/screens/diseases/skin_diseases/add_new_skin_disease.dart';
import 'package:ctseproject/screens/diseases/skin_diseases/skin_diseases_list.dart';
import 'package:ctseproject/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AAAAlJQSsuk:APA91bHXMQi_BKi6XeZ9w0eHC0Njcv35Fw6oYOogQM5gaFvVgC_dd186BNFvevdPCKH9-BcIfq2MX2U3-qkCcE6-Y90FfzyXkc0dHA3xjUjS8kcWaygu1sizCnoSQ_rR8hwn5uUu34kK',
          appId: '1:638139413225:android:d64ffadf1bea85190e3678',
          messagingSenderId: '638139413225',
          projectId: 'ctseproj-f1817')
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disease CURE',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Homescreen.routeName,
      routes: {
        Homescreen.routeName: (context)=> const Homescreen(),
        SkinDiseaseList.routeName: (context) => const SkinDiseaseList(),
        AddNewSkinDisease.routeName: (context) => const AddNewSkinDisease(),

      },
    );
  }
}
