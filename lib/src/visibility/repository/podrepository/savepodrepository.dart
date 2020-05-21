import 'package:jaguar_resty/jaguar_resty.dart';
import 'package:tvs_visibility/src/visibility/model/podmodel/postpoddetailsmodel.dart';
import 'package:tvs_visibility/src/visibility/networkprovider/podprovider/savepodprovider.dart';

class SavePodRepository {
  SavePodProvider mSavePodProvider;

  SavePodRepository(this.mSavePodProvider);

  Future<String> onSavePodResponse(PostPodDetailsModel model) {
    return mSavePodProvider.getSavePodResult(model);
  }
}
