import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFDownload {
  PDFDownload();

  Future<File> getPDFFile(String url) async {
    File fileSave;
    try {
      var response = await http.get(Uri.parse(url));
      print(response.request.url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        String head = response.headers["content-disposition"];
        String filename = head.replaceAll("attachment; filename=", "");
        String dir = (await getApplicationDocumentsDirectory()).path;
        print(dir);
        fileSave = new File('$dir/$filename');
        fileSave.writeAsBytes(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
        return fileSave;
      } else {
        print('Error resposnse');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
