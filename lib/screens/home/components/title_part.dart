import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleAboutDiseases extends StatelessWidget {
  const TitleAboutDiseases({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
      child: Row(
        children: [
          TitleWithCustomUnderline(
            text: "Recomended",
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefalutPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(right: kDefalutPadding / 4),
                height: 7,
                color: kPrimaryColor.withOpacity(0.2),

              )
          )
        ],
      ),
    );
  }
}

