import 'package:flutter/material.dart';
import 'package:speed_reader_pro/screen/rsvp.dart';

void main() {
  runApp(const MaterialApp(
    title: 'SpeedReaderPro',
    home: TextInput(),
  ));
}

class TextInput extends StatelessWidget {
  const TextInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpeedReaderPro'),
        backgroundColor: Colors.grey, // Grayscale color
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
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Grayscale color
              ),
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
        title: Text('Input Text'),
        backgroundColor: Colors.grey[800], // Grayscale color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Added Container for the text above TextField
            Container(
              margin: EdgeInsets.only(bottom: 10), // Adjust as needed
              child: Text(
                'Enter your text below:',
                style: TextStyle(fontSize: 16, color: Colors.grey), // Grayscale color
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                controller: textController,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'Enter your text here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Grayscale color
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
                    builder: (context) => RSVP(enteredText.split(RegExp(r'\s+'))),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[800], // Grayscale color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
