import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:printing/printing.dart';

class MyPdfView extends StatefulWidget {
  String title;
  String path;

  MyPdfView({@required this.path, this.title = 'PDF Viewer'});

  @override
  _MyPdfViewState createState() =>
      _MyPdfViewState(
        path,
        title,
      );
}

class _MyPdfViewState extends State<MyPdfView> {
  String mPath;
  String mTitle;
  File generatedPdfFile;

  _MyPdfViewState(this.mPath, this.mTitle);

  @override
  void initState() {
    loadLocalPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        path: mPath,
        appBar: AppBar(
          centerTitle: true,
          title: Text(mTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.print),
              color: Colors.white,
              onPressed: () {
                printView();
              },
            )
          ],
        ));
  }

  void printView() async {
    ByteData pdfFile;
    pdfFile = await rootBundle.load('$mPath');
    generatedPdfFile = File('$mPath');
    await generatedPdfFile.writeAsBytes(pdfFile.buffer
        .asUint8List(pdfFile.offsetInBytes, pdfFile.lengthInBytes));

    var pdfBytes = await generatedPdfFile.readAsBytes();
    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
  }

  void loadLocalPdf() async {
    ByteData pdfFile;
    pdfFile = await rootBundle.load('$mPath');
    generatedPdfFile = File('$mPath');
    await generatedPdfFile.writeAsBytes(pdfFile.buffer
        .asUint8List(pdfFile.offsetInBytes, pdfFile.lengthInBytes));
  }
}
