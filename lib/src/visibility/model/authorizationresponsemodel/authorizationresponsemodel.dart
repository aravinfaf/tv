import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'authorizationresponsemodel.jser.dart';

class AuthorizationResponseModel {
  String tenantId;
  String userId;
  String siteId;
  String workflowTenantId;
  String warehouseManagerUserId;
  String userName;
  String appVersion;
  List<String> groupList;
  List<dynamic> accountList;
  List<String> processList;
  @Alias("allowedChars")
  String mAllowedCharacters;
  List<WorkflowProcessMasterList> workflowProcessMasterDTOList;
  @Ignore()
  bool error = false;

  AuthorizationResponseModel({this.tenantId,
    this.userId,
    this.siteId,
    this.workflowTenantId,
    this.warehouseManagerUserId,
    this.userName,
    this.groupList,
    this.accountList,
    this.processList,
    this.workflowProcessMasterDTOList,
    this.appVersion});
}

@GenSerializer()
class AuthorizationResponseModelSerializer
    extends Serializer<AuthorizationResponseModel>
    with _$AuthorizationResponseModelSerializer {}

class WorkflowProcessMasterList {
  String id;
  String processName;
  String processKey;
  List<WorkflowActivityMasterList> workflowActivityMasterDTOList;

  WorkflowProcessMasterList({
    this.id,
    this.processName,
    this.processKey,
    this.workflowActivityMasterDTOList,
  });

  String get getId => id;

  String get getProcessName => processName;

  String get getProcessKey => processKey;

  List<WorkflowActivityMasterList> get getWorkFlowActivityMasterList =>
      workflowActivityMasterDTOList;
}

@GenSerializer()
class WorkflowProcessMasterListSerializer
    extends Serializer<WorkflowProcessMasterList>
    with _$WorkflowProcessMasterListSerializer {}

class WorkflowActivityMasterList {
  String id;
  String taskKey;
  String taskName;
  String processId;
  dynamic followUpDate;
  String activityId;
  dynamic userList;
  String formKey;
  dynamic dueDate;
  dynamic groupList;
  dynamic assignee;
  String tblStatusCodeMasterId;
  List<FormFieldList> formFieldList;

  WorkflowActivityMasterList({this.id,
    this.taskKey,
    this.taskName,
    this.processId,
    this.followUpDate,
    this.activityId,
    this.userList,
    this.formKey,
    this.dueDate,
    this.groupList,
    this.assignee,
    this.formFieldList, this.tblStatusCodeMasterId});

  String get getTaskKey => taskKey;

  String get getTaskName => taskName;
}

@GenSerializer()
class WorkflowActivityMasterListSerializer
    extends Serializer<WorkflowActivityMasterList>
    with _$WorkflowActivityMasterListSerializer {}

class FormFieldList {
  dynamic datePattern;
  String fieldId;
  dynamic defaultValue;
  dynamic fieldLabel;
  String fieldType;
  dynamic formFieldConstraintList;
  List<FormFieldProperty> formFieldProperties;

  FormFieldList({
    this.datePattern,
    this.fieldId,
    this.defaultValue,
    this.fieldLabel,
    this.fieldType,
    this.formFieldConstraintList,
    this.formFieldProperties,
  });
}

@GenSerializer()
class FormFieldListSerializer extends Serializer<FormFieldList>
    with _$FormFieldListSerializer {}

class FormFieldProperty {
  String propertyId;
  dynamic propertyName;
  String propertyValue;

  FormFieldProperty({
    this.propertyId,
    this.propertyName,
    this.propertyValue,
  });
}

@GenSerializer()
class FormFieldPropertySerializer extends Serializer<FormFieldProperty>
    with _$FormFieldPropertySerializer {}

class FieldType {
  String fieldType;
}

@GenSerializer()
class FieldTypeSerializer extends Serializer<FieldType>
    with _$FieldTypeSerializer {}
