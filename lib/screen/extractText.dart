// import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
import 'package:read_pdf_text/read_pdf_text.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

Future<String> extractTextFromPDF(String filePath) async {
  String text = "";
  try {
    text = await ReadPdfText.getPDFtext(filePath);
  } on PlatformException {
    print("failed to get pdf text");
  }
  return text;

}