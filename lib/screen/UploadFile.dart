import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speed_reader_pro/screen/extractText.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PDF Text Extraction'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              String? filePath = await pickPDFFile();
              if (filePath != null) {
                String extractedText = await extractTextFromPDF(filePath);
                print(extractedText);
              } else {
                print('File picking canceled.');
              }
            },
            child: Text('Upload PDF'),
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