import 'package:flutter/material.dart';
import 'package:speed_reader_pro/screen/rsvp.dart';

void main() {
  runApp(MaterialApp(
    title: 'SpeedReaderPro',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpeedReaderPro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Input Text'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputText()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InputText extends StatefulWidget {
  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ashwin Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                controller: textController,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'Enter your text here',
                  border: OutlineInputBorder(  // Add border
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            ElevatedButton(
              child: Text('Submit Text'),
              onPressed: () {
                String enteredText = textController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RSVP(enteredText),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
