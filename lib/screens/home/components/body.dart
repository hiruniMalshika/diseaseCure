import 'package:ctseproject/screens/home/components/recomending_diseases.dart';
import 'package:ctseproject/screens/home/components/title_part.dart';
import 'package:flutter/material.dart';

import 'header_with_searchbox.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleAboutDiseases(),
          RecomendingDiseases()
        ],
      ),
    );
  }
}

