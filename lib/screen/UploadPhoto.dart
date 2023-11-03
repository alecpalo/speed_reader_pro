import 'package:flutter/material.dart';
import 'dart:async';

class UploadPhoto extends StatefulWidget {
  @override
  _TextChangingButtonState createState() => _TextChangingButtonState();
}

class _TextChangingButtonState extends State<UploadPhoto> {
  bool isChangingText = false;
  String buttonText = "Start Changing Text";
  StreamController<String> textChangeController = StreamController<String>();

  void changeText() {
    if (!isChangingText) {
      isChangingText = true;
      buttonText = "Stop Changing Text";
      Stream<String>.periodic(Duration(seconds: 2), (x) => "Text Changed: $x")
          .takeWhile((_) => isChangingText)
          .listen((newText) {
        setState(() {
          buttonText = newText;
        });
      });
    } else {
      isChangingText = false;
      buttonText = "Start Changing Text";
    }
    setState(() {});
  }

  @override
  void dispose() {
    textChangeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Changing Button Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              buttonText,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: changeText,
              child: Text("Change Text"),
            ),
          ],
        ),
      ),
    );
  }
}

