import 'package:tvs_visibility/src/visibility/utililty/utils.dart';
import 'package:tvs_visibility/src/visibility/wdsihelper/base/baseinterface.dart';

class MobileNumberValidation implements Validator {
  @override
  String getValidation(String val, String validationMessage) {
    return Utils.isValidMobileNumber(val) ? null : validationMessage;
  }
}

class DamageQtyValidation implements Validator {
  String receivedQty;
  DamageQtyValidation(this.receivedQty);
  @override
  String getValidation(String val, String validationMessage) {
    return !Utils.isEmpty(val) ? !(int.parse('$receivedQty')<int.parse('$val')) ?null:'Damage qty cannot be greater than received qty' :validationMessage;
  }
}

