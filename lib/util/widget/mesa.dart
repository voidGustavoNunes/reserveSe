import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MesaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.brown,
      child: Center(child: Text("Mesa")),
    );
  }
}