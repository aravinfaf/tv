import 'package:tvs_visibility/src/visibility/dataprovider/sharedprefs.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/singlebintobinprovider/singlebintobinprovider.dart';

class SingleBinToBinRepository {
  SingleBinToBinProvider mBinNetProvider;
  CustomSharedPrefs mSharedPrefs;

  SingleBinToBinRepository(this.mBinNetProvider, this.mSharedPrefs);

  Future<int> singleBinToBinTransfer(String binOrPart, String binId) async =>
      mBinNetProvider.onSingleBinToBinTransfer(binOrPart, binId);
}
