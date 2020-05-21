import 'dart:collection';

import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/model/picking/CustomPickList.dart';
import 'package:tvs_visibility/src/visibility/model/picking/pickingmodel.dart';
import 'package:tvs_visibility/src/visibility/modelmapper/pickingmapper.dart';
import 'package:tvs_visibility/src/visibility/repository/Picking/pickingrepos.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/base/baseinterface.dart';

class PickBloc extends BaseBloc {
  PickingRespos mPickingRepository ;
  CustomSharedPrefs mCustomSharedPreferences;
  var userDetails = HashMap<String, dynamic>();
  PickingModelMapper mModelMapper;

  PickBloc(this.mPickingRepository,this.mCustomSharedPreferences,this.mModelMapper);

  Future<List<PickingLocationModel>> OnProcessing(
      String filter,
      String filterColumn,
      bool paging,
      int currentPage,
      int limit,
      String minDate) async {
    userDetails = await mCustomSharedPreferences.getUserDetails();
    String siteId = await userDetails['siteId'];
    String userId = await userDetails['userId'];
    showProgress(true);
    var data = await mPickingRepository.getpickingList(new CustomPickList(
        column: filterColumn,
        search: filter,
        pageSize: limit,
        pageNumber: currentPage,
        siteId: siteId,
        userId: userId));
    showProgress(false);
    return mModelMapper.reverseList(data.pickLocationDTOList) ?? [];
  }
}
