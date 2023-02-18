import 'package:flutter/material.dart';

class SignalerPage extends StatelessWidget {
  const SignalerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: Text("Signaler")),
    );
  }
}