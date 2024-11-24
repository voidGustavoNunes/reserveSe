import 'package:flutter/material.dart';

class JanelaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.deepOrange,
      child: Center(child: Text("Janela")),
    );
  }
}