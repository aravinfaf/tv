class BusinessConstants{
  //APP DETAILS
  static const String APP_ID="2";  //HUSQVARNA
  static const String APP_VERSION="1.0.1";
  //MODULES
  static const String MODULE_INWARD = "Inward";
  static const String MODULE_BINNING = "Binning";
  static const String MODULE_PICKING = "Picking";
  static const String MODULE_BIN_TO_BIN_TRANSFER= "Bin To Bin Transfer";
  //PARTS
  static const int V_PART=1;
  static const int NV_PART=2;
  static const String STR_V_PART="V";
  static const String STR_NV_PART="NV";
  static const String STR_VARIABLE_PART="Variable Parts";
  static const String STR_NON_VARIABLE_PART="NonVariable Parts";
  //INWARD
  static const int INVALID_PARAMETERS=0;
  static const int INVALID_PART_NUMBER=1;

  static const int PROCEEDED_V_PART=2;
  static const int PROCEEDED_NV_PART=3;
  //BINNING
  static const int BINNING_ALREADY_COMPLETED=1;
  static const int BIN_INVALID_SERIAL_NUMBER=2;
  static const int BIN_SITE_BIN_NOT_MATCH=3;
  static const int BINNING_SUCCESS_PROCEED=4;
  static const int BIN_PART_BIN_SUCCESS=5;
  static const int BIN_SHORT_ACCEPTED=6;
  static const int BINNING_SHORT=7;
  static const int COMPLETE_BINNING=8;
  static const int BIN_SCAN_SUCCESS=9;
  static const int THIS_IS_VPART=10;


  static const String STR_BINNING_ALREADY_COMPLETED="Binning already completed";
  static const String STR_BIN_INVALID_SERIAL_NUMBER="Invalid serial number";
  static const String STR_BIN_INVALID_BIN_NUMBER="Invalid bin number";
  static const String STR_BIN_SITE_BIN_NOT_MATCH="Site and bin not matched";
  static const String STR_BINNING_SUCCESS_PROCEED="Binning success,Proceed";
  static const String STR_BIN_PART_BIN_SUCCESS="Part Binned Success";
  static const String STR_BIN_SCAN_BIN_FIRST="Scan bin first";
  static const String STR_BIN_SHORT_ACCEPTED="Short accepted";

  static const int BINNING_BIN_LOCATION_SITE_MAPPED=1;
  static const int BINNING_SERIAL_NUMBER_MAPPED_TO_BIN=2;
  static const int BINNING_PART_SERIAL_NUMBER_NOT_BINNED=3;
  static const int BINNING_INVALID_SERIAL_NUMBER=4;
  static const int BINNING_BIN_NOT_SCANNED_FOR_SERIAL_NUMBER=5;
  static const int BINNING_SERIAL_NUMBER_ALREADY_IN_SAME_BIN=6;
  static const int BINNING_BIN_TYPE_MISMATCH=7;
  static const int BINNING_SERIAL_NUMBER_NOT_AVAILABLE_IN_BIN=8;

  //PICKING
  static const int PICKING_INVALID_SERIAL_NUMBER=1;
  static const int PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE=2;
  static const int PICKING_QUANTITY_AVAILABLE=3;

  static const String STR_PICKING_INVALID_SERIAL_NUMBER="Invalid serial number";
  static const String STR_PICKING_REQUESTED_QUANTITY_NOT_AVAILABLE="Requested quantity not available";

  static const String PICKING_DESPATCH="DITM6";
  static const String PICKING_WORKSHOP="DITM7";

  static const String STR_PICKING_SERIAL_NUMBER_NOT_MATCH="Serial number doesn't match";
  //INVALID
  static const String STR_INVALID_PARAMETERS="Invalid parameters";
  static const String STR_INVALID_PART_NUMBER="Invalid part number";
  static const String STR_INVALID_SERIAL_NUMBER="Invalid serial Number";

}
