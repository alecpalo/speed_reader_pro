import 'package:flutter/material.dart';
import 'package:speed_reader_pro/screen/InputText.dart';
import 'package:speed_reader_pro/screen/UploadFile.dart';

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
      appBar: null,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image at the top
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/SpeedReadReal.png', // Replace with your actual image path
                width: 1000,
                height: 200,
              ),
            ),
            SizedBox(height: 250), // Reduced the SizedBox height
            // Buttons in the middle center
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputText()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800], // Dark gray background color
                  padding: EdgeInsets.zero,
                ),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Enter Text',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UploadFile()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800], // Dark gray background color
                  padding: EdgeInsets.zero,
                ),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Upload PDF',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
