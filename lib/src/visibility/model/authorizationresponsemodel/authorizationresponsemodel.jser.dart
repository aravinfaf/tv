// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizationresponsemodel.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AuthorizationResponseModelSerializer
    implements Serializer<AuthorizationResponseModel> {
  Serializer<WorkflowProcessMasterList> __workflowProcessMasterListSerializer;
  Serializer<WorkflowProcessMasterList>
      get _workflowProcessMasterListSerializer =>
          __workflowProcessMasterListSerializer ??=
              WorkflowProcessMasterListSerializer();
  @override
  Map<String, dynamic> toMap(AuthorizationResponseModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'tenantId', model.tenantId);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'siteId', model.siteId);
    setMapValue(ret, 'workflowTenantId', model.workflowTenantId);
    setMapValue(ret, 'warehouseManagerUserId', model.warehouseManagerUserId);
    setMapValue(ret, 'userName', model.userName);
    setMapValue(ret, 'appVersion', model.appVersion);
    setMapValue(ret, 'groupList',
        codeIterable(model.groupList, (val) => val as String));
    setMapValue(ret, 'accountList',
        codeIterable(model.accountList, (val) => passProcessor.serialize(val)));
    setMapValue(ret, 'processList',
        codeIterable(model.processList, (val) => val as String));
    setMapValue(ret, 'allowedChars', model.mAllowedCharacters);
    setMapValue(
        ret,
        'workflowProcessMasterDTOList',
        codeIterable(
            model.workflowProcessMasterDTOList,
            (val) => _workflowProcessMasterListSerializer
                .toMap(val as WorkflowProcessMasterList)));
    return ret;
  }

  @override
  AuthorizationResponseModel fromMap(Map map) {
    if (map == null) return null;
    final obj = AuthorizationResponseModel();
    obj.tenantId = map['tenantId'] as String;
    obj.userId = map['userId'] as String;
    obj.siteId = map['siteId'] as String;
    obj.workflowTenantId = map['workflowTenantId'] as String;
    obj.warehouseManagerUserId = map['warehouseManagerUserId'] as String;
    obj.userName = map['userName'] as String;
    obj.appVersion = map['appVersion'] as String;
    obj.groupList = codeIterable<String>(
        map['groupList'] as Iterable, (val) => val as String);
    obj.accountList = codeIterable<dynamic>(map['accountList'] as Iterable,
        (val) => passProcessor.deserialize(val));
    obj.processList = codeIterable<String>(
        map['processList'] as Iterable, (val) => val as String);
    obj.mAllowedCharacters = map['allowedChars'] as String;
    obj.workflowProcessMasterDTOList = codeIterable<WorkflowProcessMasterList>(
        map['workflowProcessMasterDTOList'] as Iterable,
        (val) => _workflowProcessMasterListSerializer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$WorkflowProcessMasterListSerializer
    implements Serializer<WorkflowProcessMasterList> {
  Serializer<WorkflowActivityMasterList> __workflowActivityMasterListSerializer;
  Serializer<WorkflowActivityMasterList>
      get _workflowActivityMasterListSerializer =>
          __workflowActivityMasterListSerializer ??=
              WorkflowActivityMasterListSerializer();
  @override
  Map<String, dynamic> toMap(WorkflowProcessMasterList model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'getId', model.getId);
    setMapValue(ret, 'getProcessName', model.getProcessName);
    setMapValue(ret, 'getProcessKey', model.getProcessKey);
    setMapValue(
        ret,
        'getWorkFlowActivityMasterList',
        codeIterable(
            model.getWorkFlowActivityMasterList,
            (val) => _workflowActivityMasterListSerializer
                .toMap(val as WorkflowActivityMasterList)));
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'processName', model.processName);
    setMapValue(ret, 'processKey', model.processKey);
    setMapValue(
        ret,
        'workflowActivityMasterDTOList',
        codeIterable(
            model.workflowActivityMasterDTOList,
            (val) => _workflowActivityMasterListSerializer
                .toMap(val as WorkflowActivityMasterList)));
    return ret;
  }

  @override
  WorkflowProcessMasterList fromMap(Map map) {
    if (map == null) return null;
    final obj = WorkflowProcessMasterList();
    obj.id = map['id'] as String;
    obj.processName = map['processName'] as String;
    obj.processKey = map['processKey'] as String;
    obj.workflowActivityMasterDTOList =
        codeIterable<WorkflowActivityMasterList>(
            map['workflowActivityMasterDTOList'] as Iterable,
            (val) => _workflowActivityMasterListSerializer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$WorkflowActivityMasterListSerializer
    implements Serializer<WorkflowActivityMasterList> {
  Serializer<FormFieldList> __formFieldListSerializer;
  Serializer<FormFieldList> get _formFieldListSerializer =>
      __formFieldListSerializer ??= FormFieldListSerializer();
  @override
  Map<String, dynamic> toMap(WorkflowActivityMasterList model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'getTaskKey', model.getTaskKey);
    setMapValue(ret, 'getTaskName', model.getTaskName);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'taskKey', model.taskKey);
    setMapValue(ret, 'taskName', model.taskName);
    setMapValue(ret, 'processId', model.processId);
    setMapValue(
        ret, 'followUpDate', passProcessor.serialize(model.followUpDate));
    setMapValue(ret, 'activityId', model.activityId);
    setMapValue(ret, 'userList', passProcessor.serialize(model.userList));
    setMapValue(ret, 'formKey', model.formKey);
    setMapValue(ret, 'dueDate', passProcessor.serialize(model.dueDate));
    setMapValue(ret, 'groupList', passProcessor.serialize(model.groupList));
    setMapValue(ret, 'assignee', passProcessor.serialize(model.assignee));
    setMapValue(ret, 'tblStatusCodeMasterId', model.tblStatusCodeMasterId);
    setMapValue(
        ret,
        'formFieldList',
        codeIterable(model.formFieldList,
            (val) => _formFieldListSerializer.toMap(val as FormFieldList)));
    return ret;
  }

  @override
  WorkflowActivityMasterList fromMap(Map map) {
    if (map == null) return null;
    final obj = WorkflowActivityMasterList();
    obj.id = map['id'] as String;
    obj.taskKey = map['taskKey'] as String;
    obj.taskName = map['taskName'] as String;
    obj.processId = map['processId'] as String;
    obj.followUpDate = passProcessor.deserialize(map['followUpDate']);
    obj.activityId = map['activityId'] as String;
    obj.userList = passProcessor.deserialize(map['userList']);
    obj.formKey = map['formKey'] as String;
    obj.dueDate = passProcessor.deserialize(map['dueDate']);
    obj.groupList = passProcessor.deserialize(map['groupList']);
    obj.assignee = passProcessor.deserialize(map['assignee']);
    obj.tblStatusCodeMasterId = map['tblStatusCodeMasterId'] as String;
    obj.formFieldList = codeIterable<FormFieldList>(
        map['formFieldList'] as Iterable,
        (val) => _formFieldListSerializer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$FormFieldListSerializer implements Serializer<FormFieldList> {
  Serializer<FormFieldProperty> __formFieldPropertySerializer;
  Serializer<FormFieldProperty> get _formFieldPropertySerializer =>
      __formFieldPropertySerializer ??= FormFieldPropertySerializer();
  @override
  Map<String, dynamic> toMap(FormFieldList model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'datePattern', passProcessor.serialize(model.datePattern));
    setMapValue(ret, 'fieldId', model.fieldId);
    setMapValue(
        ret, 'defaultValue', passProcessor.serialize(model.defaultValue));
    setMapValue(ret, 'fieldLabel', passProcessor.serialize(model.fieldLabel));
    setMapValue(ret, 'fieldType', model.fieldType);
    setMapValue(ret, 'formFieldConstraintList',
        passProcessor.serialize(model.formFieldConstraintList));
    setMapValue(
        ret,
        'formFieldProperties',
        codeIterable(
            model.formFieldProperties,
            (val) =>
                _formFieldPropertySerializer.toMap(val as FormFieldProperty)));
    return ret;
  }

  @override
  FormFieldList fromMap(Map map) {
    if (map == null) return null;
    final obj = FormFieldList();
    obj.datePattern = passProcessor.deserialize(map['datePattern']);
    obj.fieldId = map['fieldId'] as String;
    obj.defaultValue = passProcessor.deserialize(map['defaultValue']);
    obj.fieldLabel = passProcessor.deserialize(map['fieldLabel']);
    obj.fieldType = map['fieldType'] as String;
    obj.formFieldConstraintList =
        passProcessor.deserialize(map['formFieldConstraintList']);
    obj.formFieldProperties = codeIterable<FormFieldProperty>(
        map['formFieldProperties'] as Iterable,
        (val) => _formFieldPropertySerializer.fromMap(val as Map));
    return obj;
  }
}

abstract class _$FormFieldPropertySerializer
    implements Serializer<FormFieldProperty> {
  @override
  Map<String, dynamic> toMap(FormFieldProperty model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'propertyId', model.propertyId);
    setMapValue(
        ret, 'propertyName', passProcessor.serialize(model.propertyName));
    setMapValue(ret, 'propertyValue', model.propertyValue);
    return ret;
  }

  @override
  FormFieldProperty fromMap(Map map) {
    if (map == null) return null;
    final obj = FormFieldProperty();
    obj.propertyId = map['propertyId'] as String;
    obj.propertyName = passProcessor.deserialize(map['propertyName']);
    obj.propertyValue = map['propertyValue'] as String;
    return obj;
  }
}

abstract class _$FieldTypeSerializer implements Serializer<FieldType> {
  @override
  Map<String, dynamic> toMap(FieldType model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'fieldType', model.fieldType);
    return ret;
  }

  @override
  FieldType fromMap(Map map) {
    if (map == null) return null;
    final obj = FieldType();
    obj.fieldType = map['fieldType'] as String;
    return obj;
  }
}
