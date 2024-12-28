import 'package:flutter/material.dart';
import 'screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter CRUD App',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ItemListScreen(),
  ));
}
