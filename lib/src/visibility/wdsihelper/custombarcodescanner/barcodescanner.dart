import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class BarCodeScanner {
  static Future<String> barcodeScanning(BuildContext context) async {
    String barcode = 'no data scanned';
    try {
      barcode = await BarcodeScanner.scan();
      if (barcode != null) {
        print(barcode);
        return barcode.trim();
      }
    } on Exception catch (e) {
      if (e.toString() == BarcodeScanner.CameraAccessDenied) {
        return barcode = 'PERMISSION_NOT_GRANTED';
      } else {
        return barcode = 'Cancelled';
      }
    }
    return barcode;
  }
}
