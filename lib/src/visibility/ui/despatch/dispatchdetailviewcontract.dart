import 'package:flutter/material.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/despatchdetailstatusmodel.dart';
import 'package:tvs_visibility/src/visibility/model/despatchlistmodel/dispatchdetailsmodel.dart';

class DispatchDetailViewContract{
  setValidationMessage(String validationMessage,bool isSuccess){}

  setDispatchDetails(DespatchDetailStatus despatchDetailStatus){}

  setAlreadyScannedDispatchDetails(bool scanned){}

  finishDispatch(String vNo, String cId) {}

  TextEditingController getTecCartonOrLPN(){}
}

class DispatchDetailViewBlocContract{
  getDespatchStatus(String consolidationId){}

  getDispatchDetails(String deliveryType, String consolidationId, String actorType, String orderMasterId){}

  getModeOfTransport(){}

  scanDespatch(DispatchListDTO model, String tecModeOfTransport, String courierOrVehicleNumber, String scanNumber,String modeOfTransportId){}

  generatePackingSlip(String vNo, String cId,String modId){}
}
