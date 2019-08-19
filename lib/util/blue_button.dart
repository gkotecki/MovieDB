import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final Function onPressed;
  String text;

  BlueButton(this.text, Function this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 22, color: Colors.white)),
      ),
    );
  }
}
