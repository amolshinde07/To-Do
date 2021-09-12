import 'package:flutter/material.dart';
class SlideRightBackground extends StatelessWidget {
  const SlideRightBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.check,
                color: Colors.white,
              ),
              Text(
                "Done",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      );
  }
}
