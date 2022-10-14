import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  errorStyle:
      TextStyle(color: Colors.brown[900], backgroundColor: Colors.brown[100]),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2),
  ),
);
