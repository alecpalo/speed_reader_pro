import 'package:flutter/material.dart';
import 'package:speed_reader_pro/screen/UploadPhoto.dart';
import 'package:speed_reader_pro/screen/InputText.dart';
import 'package:speed_reader_pro/screen/UploadPhoto.dart'; // Import the new page

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
            ElevatedButton(
              child: Text('Upload Photo'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadPhoto()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
