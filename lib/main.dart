import 'dart:io';

import 'package:device_simulator/device_simulator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_poc/pdf_format.dart';
// import 'package:pdf/widgets.dart';

const bool debugEnableDeviceSimulator = true;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeviceSimulator(
        brightness: Brightness.dark,
        enable: debugEnableDeviceSimulator,
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () => viewPdf(context),
          )
        ],
      ),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}

viewPdf(context) async {
  final pdf = createSamplePdf();

  final String dir = (await getExternalStorageDirectory()).path;
  final path = "$dir/example.pdf";
  print(path);
  final file = File(path);
  await file.writeAsBytes(pdf.save());
  // return PdfViewerPage(path: path);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
}

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}
