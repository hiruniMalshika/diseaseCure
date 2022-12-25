import 'package:ctseproject/screens/home/components/body.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  static String routeName = '/';
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
    );
  }
}
