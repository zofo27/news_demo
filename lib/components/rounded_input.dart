import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final Size size;
  const RoundedInput({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width *.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.mail),hintText: 
        ),
      ),
    );
  }
}