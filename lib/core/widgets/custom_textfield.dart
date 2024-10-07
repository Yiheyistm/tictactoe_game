import 'package:flutter/material.dart';
import 'package:tictactoe_game/core/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.readOnly = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2
              // offset: const Offset(1, 1),
              ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        onTapOutside: (value) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: bgColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
