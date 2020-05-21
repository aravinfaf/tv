class BusinessConstants {
  static const String processKey1 = "WDSI_Inbound_Process";
  static const String processKey2 = "WDSI_Outbound_Process";
  static const String processKey3 = "WDSI_Dealer";
  static const String taskKey1 = "WDSI_InboundProcess_ListPodrecords";
  static const String taskKey2 = "WDSI_InboundProcess_generatePOD";
  static const String taskKey3 = "WDSI_Inbound_AwaitingBinning";
  static const String taskKey4 = "WDSI_Inbound_binPart";
  static const String taskKey5 = "WDSI_Outbound_PickingUser";
  static const String taskKey6 = "WDSI_outbound_PickingGeneration";
  static const String taskKey7 = "WDSI_inbound_gateIn";
  static const String taskKey8 = "WDSI_Dealer_Binning";
  static const String taskKey9 = "WDSI_Dealer_Picking";
  static const String taskKey10 = "WDSI_Dealer_BinToBin";
  static const String taskKey11 = "WDSI_Outbound_Despatch";
  static const String taskKey12 = "PreBinning_White_Marking";
  static const String taskKey13 = "PreBinning_Oil_Pasting";
  static const String taskKey14 = "PreBinning_Lazer_Marking";

  static const String taskKey15 = "PreBinning_Container_Packing";
  static const String taskKey16 = "PreBinning_VCI_Cover";
  static const String taskKey17 = "PreBinning_Black_Cover_Chalk_Dust";
  static const String taskKey18 = "PreBinning_Pre_Pack_Pouch";
  static const String taskKey19 = "PreBinning_Pre_Pack_Carton";
  static const String taskKey20 = "PreBinning_Pre_Pack_Bubble_Wrap";
  static const String taskKey21 = "PreBinning_ID_Label";
  static const String taskKey22 = "PreBinning_Put_Away";
  static const String taskKey23 = "WDSI_Outbound_Bintobin_singleBin";
  static const String taskKey24= "PreBinning_Manual_Marking";
  static const String taskKey25 = "PreBinning_Wood_Packing";

  static const String TASK_KEY_FOR_POD_GENERATION ="WDSI_InboundProcess_generatePOD";
  static const String taskDefinitionId = "WDSI_Outbound_Dispatch";
  //PARTS
  static const int V_PART = 1;
  static const int NV_PART = 2;
  static const String STR_V_PART = "V";
  static const String STR_NV_PART = "NV";
  static const String STR_VARIABLE_PART = "Variable Parts";
  static const String STR_NON_VARIABLE_PART = "NonVariable Parts";
  //BINNING
  static const String Actor_Type_Id_Warehouse = "AM001";
  static const String Actor_Type_Id_Dealer = "AM002";

  static const int BINNING_PLEASE_SCAN_BIN_FIRST = 0;
  static const int BINNING_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN = 6;
  static const int BINNING_PART_ALREADY_SCANNED = 2;
  static const int BINNING_PLEASE_SCAN_CORRECT_SERIAL_NUMBER = 7;
  static const int BINNING_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT = 8;
  static const int BINNING_PLEASE_SCAN_DISCREPANCY_PARTS = 9;
  static const int BINNING_COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY = 10;
  static const int BINNING_SUCCESSFULLY_SCANNED_BIN = 1;
  static const int BINNING_PLEASE_ENTER_THE_QUANTITY = 3;
  static const int BINNING_SUCCESSFULLY_SCANNED_PART = 4;
  static const int BINNING_ALL_PARTS_ARE_BINNED_SUCCESSFULLY = 5;
  static const int BINNING_WARE_HOUSE_MANAGER_APPROVAL_PENDING = 11;
  static const int BINNING_EXCESS_QUANTITY_ENTERED_FOR_ORDER_WHILE_ENTERING=12;
  static const int BINNING_ORDER_NOT_ASSIGNED_TO_USER=13;
  static const int BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_PENDING_FOR_APPROVAL=15;
  static const int BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_INCOMPLETE=16;
  static const int BINNING_DOCK_IN_PROCESS_NOT_FINISHED=17;
  static const int BINNING_POD_GENERATION_NOT_COMPLETED=18;
  static const int BINNING_POD_PENDING_FOR_APPROVAL=19;

  //Dispatch
  static const String DISPATCH_SCAN_SUCCESS = "Scan success";
  static const String DISPATCH_COMPLETED = "Dispatch completed";
  static const String DISPATCH_ALREADY_SCANNED = "Already scanned";
  static const String DISPATCH_SCAN_MISMATCH = "Scan mismatch";
  static const String DISPATCH_SCAN_CANNOT_BE_SWAPPED = "Serial no cannot be Swapped because it is Dispatched By Another Vehicle";
  static const String DISPATCH_AT_LEAST_ONE = "Scan atleast one LPN/Carton to finish";

  static const String STR_BINNING_PLEASE_SCAN_BIN_FIRST ="Please Scan the bin first";
  static const String STR_BINNING_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN = "Please Scan Correct Part with Correct Bin";
  static const String STR_BINNING_PART_ALREADY_SCANNED = "Part Already Scanned";
  static const String STR_BINNING_PLEASE_SCAN_CORRECT_SERIAL_NUMBER = "Please Scan correct Serial number";
  static const String STR_BINNING_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT = "Please Scan Correct Bin Respective to Account";
  static const String STR_BINNING_PLEASE_SCAN_DISCREPANCY_PARTS = "Please Scan Discrepancy Parts";
  static const String STR_BINNING_COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY = "Count MisMatch - Please provide actual quantity";
  static const String STR_BINNING_SUCCESSFULLY_SCANNED_BIN = "Successfully Scanned Bin";
  static const String STR_BINNING_PLEASE_ENTER_THE_QUANTITY = "Please Enter the Quantity";
  static const String STR_BINNING_SUCCESSFULLY_SCANNED_PART = "Successfully Scanned PART";
  static const String STR_BINNING_ALL_PARTS_ARE_BINNED_SUCCESSFULLY = "All parts are binned Successfully!!!";
  static const String STR_BINNING_EXCESS_QUANTITY_ENTERED_FOR_ORDER_WHILE_ENTERING="Excess quantity entered for order while binning";
  static const String STR_BINNING_ORDER_NOT_ASSIGNED_TO_USER="Order not assigned to the user";
  static const String STR_BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_PENDING_FOR_APPROVAL="Dock In process not finished and POD pending for approval";
  static const String STR_BINNING_DOCK_IN_PROCESS_NOT_FINISHED_POD_INCOMPLETE="Dock In process not finished and POD Generation incomplete";
  static const String STR_BINNING_DOCK_IN_PROCESS_NOT_FINISHED="Dock In process not finished";
  static const String STR_BINNING_POD_GENERATION_NOT_COMPLETED="POD Generation incomplete";
  static const String STR_BINNING_POD_PENDING_FOR_APPROVAL="POD pending for approval";
  static const String STR_BINNING_WARE_HOUSE_MANAGER_APPROVAL_PENDING="LPN is in warehouse manager approval";

  static const int BINNING_DEALER_PLEASE_SCAN_THE_BIN_FIRST = 0;
  static const int BINNING_DEALER_PART_ALREADY_SCANNED = 2;
  static const int BINNING_DEALER_SUCCESSFULLY_SCANNED_BIN = 1;
  static const int BINNING_DEALER_PLEASE_ENTER_THE_QUANTITY = 3;
  static const int BINNING_DEALER_SUCCESSFULLY_SCANNED_PART = 4; //PROCEED
  static const int BINNING_DEALER_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN = 6;
  static const int BINNING_DEALER_PLEASE_SCAN_CORRECT_SERIAL_NUMBER = 7;
  static const int BINNING_DEALER_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT = 8;
  static const int BINNING_DEALER_PLEASE_SCAN_DISCREPANCY_PARTS = 9;
  static const int BINNING_DEALER_COUNT_MISMATCH_PLEASE_PROVIDE_THE_ACTUAL_QUANTITY = 10;
  static const int BINNING_DEALER_ALL_PARTS_ARE_BINNED_SUCCESSFULLY = 5;

  static const String STR_BINNING_DEALER_PLEASE_SCAN_THE_BIN_FIRST = "Please Scan the bin first";
  static const String STR_BINNING_DEALER_PART_ALREADY_SCANNED = "Part Already Scanned";
  static const String STR_BINNING_DEALER_SUCCESSFULLY_SCANNED_BIN = "Successfully Scanned Bin";
  static const String STR_BINNING_DEALER_PLEASE_ENTER_THE_QUANTITY = "Please Enter the Quantity";
  static const String STR_BINNING_DEALER_SUCCESSFULLY_SCANNED_PART = "Successfully Scanned Part";
  static const String STR_BINNING_DEALER_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN = "Please Scan Correct Part with Correct Bin";
  static const String STR_BINNING_DEALER_PLEASE_SCAN_CORRECT_SERIAL_NUMBER = "Please Scan correct Serial number";
  static const String STR_BINNING_DEALER_PLEASE_SCAN_CORRECT_BIN_RESPECTIVE_TO_ACCOUNT = "Please Scan Correct Bin Respective to Account";
  static const String STR_BINNING_DEALER_PLEASE_SCAN_DISCREPANCY_PARTS ="Please Scan Discrepancy Parts";
  static const String STR_BINNING_DEALER_COUNT_MISMATCH_PLEASE_PROVIDE_THE_ACTUAL_QUANTITY = "Count MisMatch - Please provide actual quantity";
  static const String STR_BINNING_DEALER_ALL_PARTS_ARE_BINNED_SUCCESSFULLY = "All parts are binned Successfully!!!";

  static const String STR_QUANTITY_EXCEEDS_THE_LIMIT_PLEASE_ENTER_THE_QUANTITY_WITHIN_THE_LIMIT = "Quantity Exceeds the Limit !!!, Please Enter the Quantity within Limit";

  static const int PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN=0;
  static const int LESS_QUANTITY=1;
  static const int EXCESS_QUANTITY=4;
  static const int SUCCESSFULLY_SENT_TO_WAREHOUSE_MANAGER_APPROVAL=5;
  static const int FAILED_TO_SEND_TO_WAREHOUSE_MANAGER_APPROVAL=6;
  static const int SUCCESSFULLY_SCANNED_V_TYPE_PART=2;//CONTINUE
  static const int PLEASE_SCAN_DISCREPANCY_PARTS=9;
  static const int COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY=10;
  static const int ALL_PARTS_ARE_BINNED_SUCCESSFULLY=3;
  static const int BINNING_ENTERED_QUANTITY_IS_EQUAL_TO_QTY_IN_ORDER_CREATION_BUT_CLAIMING_SHORT=20;
  static const int BINNING_ENTERED_QUANTITY_IS_GREATER_THAN_QTY_FROM_ORDER_CREATION=12;
  static const int BINNING_USER_CAN_PROCEED_TO_SHORT=21;

  static const String STR_PLEASE_SCAN_CORRECT_PART_WITH_CORRECT_BIN="Please Scan Correct Part with Correct Bin";
  static const String STR_LESS_QUANTITY="Less Quantity";
  static const String STR_EXCESS_QUANTITY="Excess Quantity";
  static const String STR_SUCCESSFULLY_SCANNED_V_TYPE_PART="Successfully Scanned  V-Type Part";//CONTINUE
  static const String STR_PLEASE_SCAN_DISCREPANCY_PARTS="Please Scan Discrepancy Parts";
  static const String STR_COUNT_MISMATCH_PLEASE_PROVIDE_ACTUAL_QUANTITY="Count MisMatch - Please provide actual quantity";
  static const String STR_ALL_PARTS_ARE_BINNED_SUCCESSFULLY="All parts are binned Successfully!!!";
  static const String STR_SUCCESSFULLY_SENT_TO_WAREHOUSE_MANAGER_APPROVAL="LPN Moved to Warehouse Manager appoval";
  static const String STR_FAILED_TO_SEND_TO_WAREHOUSE_MANAGER_APPROVAL="Failed to send Warehouse manager approval";
  static const String STR_BINNING_ENTERED_QUANTITY_IS_EQUAL_TO_QTY_IN_ORDER_CREATION_BUT_CLAIMING_SHORT="Entered quantity is equal to quantity in order creation";
  static const String STR_BINNING_ENTERED_QUANTITY_IS_GREATER_THAN_QTY_FROM_ORDER_CREATION="Entered quantity is greater than quantity from order creation";
  static const String STR_BINNING_USER_CAN_PROCEED_TO_SHORT="Binned quantity is short. Do you want to proceed for approval?";
  static const String STR_BINNING_USER_CAN_PROCEED_TO_EXCESS="Binned quantity is excess. Do you want to proceed for approval?";
  static const String STR_BINNING_SHORT_EXCEPTION_NOT_ALLOWED="Short exception not allowed";

  static const String STR_PARTS_LABELS_GENERATED_SUCCESSFULLY = "Parts Labels Generated Successfully!!!";

  static const String WDSI_INBOUND_LIST_DISCREPANCY_PARTS = "WDSI_inbound_listdiscrepanyparts";
  static const String WDSI_INBOUND_BINNING = "WDSI_Inbound_Binning";

  static const String WDSI_INBOUND_CREATE_PARENT_DOCUMENT = "WDSI_inbound_createParentDocument";
  static const String WDSI_INBOUND_UPLOAD_PURCHASE_ORDER = "WDSI_inbound_uploadPurchaseOrder";
  static const String WDSI_INBOUND_PROCESS_GENERATE_POD = "WDSI_InboundProcess_generatePOD";
  static const String WDSI_INBOUND_ASSIGN_PO_TO_GENERATE_POD = "WDSI_inbound_assignPOToGeneretePOD";
  static const String POD_WAREHOUSE_MANAGER_APPROVAL = "POD_Warehouse_Manager_Approval";

  static const String STR_DOCKIN_PROCESS_NOT_YET_COMPLETED = "Dockin Process Not Yet Completed";
  static const String STR_POD_NOT_YET_GENERATED = "POD Not Yet Generated";
  static const String STR_WAITING_FOR_WAREHOUSE_MANAGER_APPROVAL = "Waiting For Warehouse Manager Approval";

  //POD
  static const String STR_PARTIAL_POD_GENERATED = "Partial POD generated";
  static const String STR_CONDITIONAL_POD_GENERATED_AND_SENT_FOR_WAREHOUSE_MANAGER_APPROVAL = "Conditional POD generated & sent for Warehouse Manager Approval";
  static const String STR_EXCESS_WITH_CONDITIONAL_POD_GENERATED_AND_SENT_FOR_WAREHOUSE_MANAGER_APPROVAL = "Excess with Conditional POD generated & sent for Warehouse Manager Approval";
  static const String STR_EXCESS_POD_GENERATED_AND_SENT_FOR_WAREHOUSE_MANAGER_APPROVAL = "Excess POD generated & sent for Warehouse Manager Approval";

  //PICKING
  // HUS STATUS
  static const int Picking_Success = 20;
  static const int Picking_Quantity_NotAvailable = 21;
  static const int Picking_ActorOrRandom_Missing = 23; // if any parameter missing
  static const int Picking_Continue = 24;
  static const int Picking_Quantity_NotGreater = 25;
  static const int Picking_Correct_Bin = 26;
  static const int Picking_InCorrect_Bin = 27;
  static const int Picking_AllPart_Picked = 28;
  static const int Picking_CorrectPartWith_Bin = 29;
  static const int Picking_QuantityDoesNotMatch = 30;

  //singleBinToBinVisibility

  static const int SINGLE_BIN_TRANSFER_DATA_MISMATCH= 0;
  static const int SINGLE_BIN_TRANSFER_LOCKED_FOR_PICKING= 1;
  static const int SINGLE_BIN_TRANSFER_SCAN_CORRECT_BIN_OR_PART = 2;
  static const int SINGLE_BIN_TRANSFER_SUCCESSFULLY_SCANNED_LPN_TO_BIN = 3;
  static const int SINGLE_BIN_TRANSFER_WRONG_BIN_TYPE= 4;
  static const int SINGLE_BIN_TRANSFER_LPN_NOT_AVAILABLE= 5;
  static const int SINGLE_BIN_TRANSFER_PART_ALREADY_EXISTS= 6;
  static const int SINGLE_BIN_TRANSFER_SUCCESSFULLY_SCANNED_BIN= 7;
  static const int SINGLE_BIN_TRANSFER_INVALID_LPN_PICKED= 8;

  static const String STR_SINGLE_BIN_TRANSFER_DATA_MISMATCH = 'Data Mismatch';
  static const String STR_SINGLE_BIN_TRANSFER_SCAN_CORRECT_BIN= 'Please scan correct bin or LPN';
  static const String STR_SINGLE_BIN_TRANSFER_PART_ALREADY_EXISTS= 'Part already exist in the same bin';
  static const String STR_SINGLE_BIN_TRANSFER_LPN_NOT_AVAILABLE='This LPN is not available';
  static const String STR_SINGLE_BIN_TRANSFER_INVALID_BIN  ='Please scan proper bin';
}
