import 'package:tvs_visibility/src/visibilitydealer/helper/constants/baseconstants.dart';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class BarCodeScanner {
  static Future<String> barcodeScanning({BuildContext context,bool isVisibility=false}) async {
    String barcode;
    try {
      barcode = await BarcodeScanner.scan();
      if(!isVisibility)
        barcode=(!Utility.isEmpty(barcode) && Utility.validSpecialCharactersInBackend(barcode,))? barcode.trim(): BaseConstants.STR_RECAPTURE_BARCODE;
      else
        barcode=!Utility.isEmpty(barcode)? barcode.trim(): BaseConstants.STR_RECAPTURE_BARCODE;
    } on Exception catch (e) {
      barcode=(e.toString()==BaseConstants.STR_PERMISSION_NOT_GRANTED)?
      BaseConstants.STR_PERMISSION_NOT_GRANTED:
      BaseConstants.STR_CANCELLED;
    }
    print(barcode);
    return barcode;
  }
}
