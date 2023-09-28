import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textField(Size size, String text, bool isNumerical, TextEditingController controller){
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: size.height /50,horizontal: size.height /50),
    child: Card(
      child: TextField(
        keyboardType: isNumerical? TextInputType.number : null,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );
}