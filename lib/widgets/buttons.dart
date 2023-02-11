import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final color;
  final txtColor;
  final String btText;
  final buttonTapped;
  const Button(
      {super.key,
      this.color,
      this.txtColor,
      required this.btText,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
                child: Text(
              btText,
              style: TextStyle(color: txtColor, fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }
}
