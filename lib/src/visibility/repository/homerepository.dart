import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';

class HomeRepository{
  CustomSharedPrefs mCustomSharedPrefs;

  HomeRepository(this.mCustomSharedPrefs);

  Future<bool> deleteUserLoggedDetails() async => await mCustomSharedPrefs.deleteUserProfile();

  Future<List<String>> getActivityDetailList() async =>
      await mCustomSharedPrefs.getActivityDetailsList();

  //Future<List<String>> getRoleList() async=>await mCustomSharedPrefs.onRoleList();

  Future<String> getUserName() async=>await mCustomSharedPrefs.userProfile();
}