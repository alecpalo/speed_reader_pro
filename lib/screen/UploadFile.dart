// creating uploading file capabilities
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speed_reader_pro/screen/extractText.dart';


class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

  // UploadFile({super.key}); // see if this helps

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PDF Text Extraction'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              String? filePath = await pickPDFFile(); // waiting on this
              if (filePath != null) {
                // Call the function to extract text from the PDF
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
      allowedExtensions: ['pdf'], // only allow pdf's
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }
}

// Future<String> extractTextFromPDF(String filePath) async {
//   final pdfBytes = await File(filePath).readAsBytes();
//
//   // Load the PDF from the buffer
//   final pdfDocument = PdfDocument.openData(pdfBytes);
//
//   // Extract text from the PDF
//   final StringBuffer textBuffer = StringBuffer();
//   for (var page in pdfDocument.pages) {
//     textBuffer.write(page.text);
//   }
//
//   return textBuffer.toString();





























//
// class _UploadFileState extends State<UploadFile> {
//   File? file;
//   FilePickerResult? result;
//   String fileText = "bruh";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('File Picker')),
//       body: Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           if (file != null || result != null) ...[
//             if (kIsWeb) ...[
//               Image.memory(
//                 result!.files.first.bytes!,
//                 height: 350,
//                 width: 350,
//                 fit: BoxFit.fill,
//               ),
//             ] else ...[
//               Image.file(file!, height: 150, width: 150, fit: BoxFit.fill),
//             ],
//             const SizedBox(height: 8),
//           ],
//           ElevatedButton(
//             onPressed: () async {
//               try {
//                 result = await FilePicker.platform.pickFiles(
//                   type: FileType.custom,
//                   allowedExtensions: ['pdf'], // only allow pdfs
//                 );
//                 if (result != null) {
//                   if (!kIsWeb) {
//                     file = File(result!.files.single.path!); // process this file
//                     String text = await ReadPdfText.getPDFtext(path);
//
//
//
//                   }
//                   setState(() {});
//                 } else {
//                   // User canceled the picker
//                 }
//               } catch (_) {}
//             },
//             child: const Text('Upload PDF'),
//           ),
//         ]),
//       ),
//     );
//   }
// }














//
// FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
//
// if (result != null) {
//   List<File> files = result.paths.map((path) => File(path)).toList();
// } else {
//   // User canceled the picker
// }
//
