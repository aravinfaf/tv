import 'dart:async';
import 'dart:collection';
import 'package:tvs_visibility/src/visibilitydealer/helper/utility/utils.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/partserialnumberdetailsmodel/partserialnumberdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postdispatchmasterdetailsmodel/postdispatchmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/model/postpartmasterdetailsmodel/postpartmasterdetailsmodel.dart';
import 'package:tvs_visibility/src/visibilitydealer/picking/repository/partnorepository.dart';
import 'package:rxdart/rxdart.dart';

class PartNumberScanDetailBloc{
  var partNumberScannedResult = BehaviorSubject<String>();
  var mProgressBar=BehaviorSubject<bool>();
  PartNoRepository mRepository;

  dispose(){
    partNumberScannedResult.close();
    mProgressBar.close();
  }

  PartNumberScanDetailBloc(this.mRepository,);

  onSetPartNumberScannedResult(String result){
    partNumberScannedResult.sink.add(result);
  }

  Observable<String> get scannedResult=>partNumberScannedResult.stream;

  Function(bool) get showProgress => mProgressBar.sink.add;

  Observable<bool> get isLoad => mProgressBar.stream;

  Future<PartSerialNumberDetailsModel> getSerialNumberValidation(String barcode,int quantity) async{
    showProgress(true);
    PartSerialNumberDetailsModel partSerialNumberDetails=PartSerialNumberDetailsModel();
    partSerialNumberDetails=await mRepository.validateSerialNumberDetails(barcode, quantity);
    if(partSerialNumberDetails.mError)
      mProgressBar.addError('Something went wrong!');
    return partSerialNumberDetails;
  }

  getRemainingQtyAvailable(int currentQty,String mSerialNumber, LinkedHashMap<String,List<PostDispatchMasterDetailsModel>> map,String partNumber,String partType,PartSerialNumberDetailsModel model) {
    int totQty=0;
    if(!Utility.isEmpty(partType) && model.mPartNumber!=null){
      if(map.containsKey(partNumber)){
        map[partNumber].forEach((m){
          totQty=totQty+m.mPickQty;
        });
      }
      totQty=totQty+currentQty;
    }else{
      totQty=0;
    }
    return totQty;
  }

  validatePartAndSerialQty(LinkedHashMap<String, PostPartMasterDetailsModel> partNoMap,LinkedHashMap<String, PostPartMasterDetailsModel> map){
    int totPartQty=0;
    int totSerialQty=0;
    partNoMap.values.forEach((v){
      totPartQty=v.mQuantity+totPartQty;
    });
    map.values.forEach((v){
      totSerialQty=v.mBinMasterDetailList[0].mQuantity+totSerialQty;
    });
    return totPartQty==totSerialQty;
  }


  getTotalPartQty(LinkedHashMap<String, PostPartMasterDetailsModel> map){
    int totQty=0;
    map.values.forEach((v){
      totQty=v.mQuantity+totQty;
    });
    return totQty;
  }

  getSerialNumberQty(LinkedHashMap<String, PostPartMasterDetailsModel> map){
    int totQty=0;
    map.values.forEach((v){
      totQty=v.mBinMasterDetailList[0].mQuantity+totQty;
    });
    return totQty;
  }

  getRemainingQty(LinkedHashMap<String, PostPartMasterDetailsModel> map){
    int totQty=0;
    map.values.forEach((v){
      totQty=totQty+(v.mQuantity-v.mBinMasterDetailList[0].mQuantity);
    });
    return totQty;
  }

  List getRemainingQtyInText(LinkedHashMap<String, PostPartMasterDetailsModel> partMap,LinkedHashMap<String, List<PostDispatchMasterDetailsModel>> map){
   List emptyData=[];
   List partNoList=[];
   int i=0;
   int reqQty=0;
   int pickQty=0;
   var partNo="";
   var lastPartNo="";

   map.values.forEach((val){
     val.forEach((model){
       if(!Utility.isEmpty(partNo) && partNo!=model.mPartNumber){
         i++;
         emptyData.add("$i)$partNo-${reqQty-pickQty}");
         partNo=model.mPartNumber;
         reqQty=model.mReqQty;
         pickQty=0;
         partNoList.add(partNo);
       }
       if(Utility.isEmpty(partNo)){
         partNo=model.mPartNumber;
         reqQty=model.mReqQty;
         partNoList.add(partNo);
       }
       lastPartNo=model.mPartNumber;
       if(partMap[partNo].mPartTypeMaster=="Variable Parts"){
         pickQty=pickQty+model.mPickQty;
       }else{
         pickQty=pickQty+model.mPickQty;
       }
     });
   });
    if(partNo==lastPartNo){
      i++;
      emptyData.add("$i)$partNo-${reqQty-pickQty}");
    }

   partMap.values.forEach((v){
     if(!partNoList.contains(v.mPartMaster)){
       i++;
       emptyData.add("$i)${v.mPartMaster}-${v.mQuantity}");
     }
   });

   return emptyData;
  }


   getTotalParts(String serialNo,LinkedHashMap<String,List<PostDispatchMasterDetailsModel>> map){
    int totQty=0;
    map.values.forEach((m){
      m.forEach((v){
        if(v.mPartSerialNo==serialNo)
          totQty=totQty+v.mPickQty;
      });
    });
    return totQty;
  }

  getPartsTotalList(String serialNo,int quantity,List<PostDispatchMasterDetailsModel> list){
    list.forEach((v){
      if(v.mPartSerialNo==serialNo)
        v.mPickQty=quantity+v.mPickQty;
    });
    return list;
  }

  //serial no
  //total parts
  getTotalPartsForPartSerialNumber(List<PostDispatchMasterDetailsModel> partNoMap) {
    int totQty=0;
    partNoMap.forEach((v){
        totQty=totQty+v.mPickQty;
    });
    return totQty;
  }

  validatePartNumberAndPartSerial(String serialNo,List<PostDispatchMasterDetailsModel> partNoMap){
    int reqQty=0;
    int pickQty=0;
    partNoMap.forEach((v){
      if(v.mPartSerialNo==serialNo) {
        reqQty=reqQty+v.mReqQty;
        pickQty = pickQty + v.mPickQty;
      }
    });
    return reqQty==pickQty;
  }

  getTotalPartsForPartNumberAndPartSerial(LinkedHashMap<String,List<PostDispatchMasterDetailsModel>> partNoMap){
    int reqQty=0;
    int pickQty=0;
    var partNo="";
    partNoMap.values.forEach((v){
      if(partNo!=v.first.mPartNumber) {
        partNo = v.first.mPartNumber;
        reqQty = reqQty + v[0].mReqQty;
      }
       pickQty=pickQty+getIndividualTotalPartSerialQty(v);
    });
    return reqQty==pickQty;
  }

  isTotalPartsForPartNumberAndPartSerialEqual(LinkedHashMap<String,PostPartMasterDetailsModel> partMap,LinkedHashMap<String,List<PostDispatchMasterDetailsModel>> partNoMap){
    List partNoList=[];
    int reqQty=0;
    int pickQty=0;
    var partNo="";
    partNoMap.values.forEach((list){
      for(PostDispatchMasterDetailsModel v in list){
        if(Utility.isEmpty(partNo)){
          partNo = v.mPartNumber;
          reqQty = reqQty + v.mReqQty;
          partNoList.add(partNo);
        }

        if(partNo!=v.mPartNumber) {
          partNo = v.mPartNumber;
          reqQty = reqQty + v.mReqQty;
          partNoList.add(partNo);
        }
        if(partMap[partNo].mPartTypeMaster=="Variable Parts"){
          pickQty=pickQty+v.mPickQty;
        }else{
          pickQty=pickQty+v.mPickQty;
        }
      }
    });
    partMap.values.forEach((v){
      if(!partNoList.contains(v.mPartMaster))
        reqQty=reqQty+v.mQuantity;
    });
    return reqQty==pickQty;
  }

  getIndividualTotalPartSerialQty(List<PostDispatchMasterDetailsModel> model){
    return model.first.mPickQty??0;
  }

  getPartNoSerialQty(String serialNo,List<PostDispatchMasterDetailsModel> model){
    return model.first.mPickQty??0;
  }

  getTotalPartSerialQty(String serialNo,List<PostDispatchMasterDetailsModel> model){
    int totQty=0;
    model.forEach((v){
      if(serialNo==v.mPartSerialNo)
        totQty=totQty+v.mReqQty;
    });
    return totQty??0;
  }

  bool isSerialNoAvailable(String serialNo,List<PostDispatchMasterDetailsModel> partNoList) {
    if(partNoList.contains(serialNo))
      return true;
    return false;
  }

  isSerialAvailableInPartNoMap(String serialNo,LinkedHashMap<String,List<PostDispatchMasterDetailsModel>> map){
    bool isExist=false;
    map.values.forEach((v){
    for(PostDispatchMasterDetailsModel list in v){
      if(list.mPartSerialNo==serialNo)
       isExist=true;
    }
    });
    return isExist;
  }

  validateTotalPartAndPartSerial(List<PostDispatchMasterDetailsModel> partNoMap){
    int pickQty=0;
    partNoMap.forEach((v){
        pickQty = pickQty + v.mPickQty;
    });
    return pickQty;
  }

  getPostDispatchMasterDetailsInList(List<List<PostDispatchMasterDetailsModel>> model){
    List<PostDispatchMasterDetailsModel> list=[];
    model.forEach((v){
      v.forEach((data){
        list.add(data);
      });
    });
    return list;
  }

}
