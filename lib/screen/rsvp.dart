import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RSVP extends StatelessWidget {
  final String text;

  RSVP(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}