import 'package:flutter/material.dart';

class StylishTextField extends StatefulWidget {
  TextEditingController? controller;
  String? label;
  StylishTextField({super.key, this.controller, this.label});

  @override
  State<StylishTextField> createState() => _StylishTextFieldState();
}

class _StylishTextFieldState extends State<StylishTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12, width: 2),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.label,
        ),
      ),
    );
  }
}
