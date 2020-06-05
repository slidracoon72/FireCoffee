import 'package:flutter/material.dart';

class VerticalReg extends StatefulWidget {
  @override
  _VerticalRegState createState() => _VerticalRegState();
}

class _VerticalRegState extends State<VerticalReg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 30),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'SIGN UP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}
