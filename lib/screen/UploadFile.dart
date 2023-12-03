import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speed_reader_pro/screen/extractText.dart';
import 'package:speed_reader_pro/screen/rsvp.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  bool isUploadComplete = false; // Example state variable to track upload status
  String extractedText = "";
  String uploadedFileName = ""; // Variable to store the uploaded file name

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Upload PDF'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey[800], // Set app bar background color to gray
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Easily transform your PDFs into readable text. '
                      'Upload a PDF, and watch as we extract the text for you. '
                      'Experience the convenience of accessing your document content instantly!',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  String? filePath = await pickPDFFile();
                  if (filePath != null) {
                    String tempText = await extractTextFromPDF(filePath);

                    // Set the state variable to indicate the upload is complete
                    setState(() {
                      extractedText = tempText;
                      isUploadComplete = true;
                      uploadedFileName = filePath.split('/').last;
                    });
                  } else {
                    print('File picking canceled.');
                  }
                },
                icon: Icon(Icons.upload_file),
                label: Text('Upload PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isUploadComplete ? Icons.check : Icons.close,
                    color: isUploadComplete ? Colors.green : Colors.red,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    isUploadComplete ? 'Upload Complete' : 'Upload Incomplete',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: isUploadComplete ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              if (isUploadComplete)
                Text(
                  'Uploaded File: $uploadedFileName',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Placeholder action for the "Continue" button
                  if (isUploadComplete) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RSVP(extractedText.split(RegExp(r'\s+'))),
                      ),
                    );
                  }
                },
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }
}
