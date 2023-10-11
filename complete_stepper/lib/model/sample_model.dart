import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../main.dart';



class SampleModel implements StepperDataHolder {
// class SampleModel  {
  @override
  final String userType;
  @override
  final String name;
  final DateTime dateTime;
  @override
  final StepperEnum status;
  final Color stepperColor;
  final Color stepperLine;
  final String statusText;
  final int someIntValue;
  final DateTime someDateTimeValue;
  final bool someBoolValue;
  @override
  final DateTime dateFormat;
  @override
  final DateTime timeFormat;
  @override
  final Axis scrollDirection;

  SampleModel({
    required this.userType,
    required this.name,
    required this.dateTime,
    required this.status,
    required this.stepperColor,
    required this.stepperLine,
    required this.statusText,
    required this.someIntValue,
    required this.someDateTimeValue,
    required this.someBoolValue,
    required this.dateFormat,
    required this.timeFormat,
    required this.scrollDirection,
  });

  factory SampleModel.fromJson(Map<String, dynamic> jsonData) {
    StepperEnum val;
    switch (jsonData['status']) {
      case 'authorized':
        val = StepperEnum.authorized;
        break;
      default:
        val = StepperEnum.returned;
    }

    return SampleModel(
      userType: jsonData['userType'] as String,
      name: jsonData['name'] as String,
      dateTime: DateTime.parse(jsonData['dateTime'] as String),
      status: val,
      stepperColor: Color(
          int.parse(jsonData['stepperColor'].substring(1, 7), radix: 16) +
              0xFF000000),
      stepperLine: Color(
          int.parse(jsonData['stepperLine'].substring(1, 7), radix: 16) +
              0xFF000000),
      statusText: jsonData['statusText'] as String,
      someIntValue: jsonData['someIntValue'] as int,
      someDateTimeValue:
          DateTime.parse(jsonData['someDateTimeValue'] as String),
      someBoolValue: jsonData['someBoolValue'] as bool,
      dateFormat: jsonData['dateFormat'] ?? DateTime.now(),
      timeFormat: jsonData['timeFormat'] ?? DateTime.now(),
      scrollDirection: jsonData['scrollDirection'] ?? Axis.horizontal,
    );
  }

  SampleModel copyWith({
    String? userType,
    String? name,
    DateTime? dateTime,
    StepperEnum? status,
    Color? stepperColor,
    Color? stepperLine,
    String? statusText,
    int? someIntValue,
    DateTime? someDateTimeValue,
    bool? someBoolValue,
    DateTime? dateFormat,
    DateTime? timeFormat,
    Axis? scrollDirection,

  }) {
    return SampleModel(
      userType: userType ?? this.userType,
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      stepperColor: stepperColor ?? this.stepperColor,
      stepperLine: stepperLine ?? this.stepperLine,
      statusText: statusText ?? this.statusText,
      someIntValue: someIntValue ?? this.someIntValue,
      someDateTimeValue: someDateTimeValue ?? this.someDateTimeValue,
      someBoolValue: someBoolValue ?? this.someBoolValue,
      dateFormat: dateFormat??this.dateFormat,
      timeFormat: timeFormat??this.timeFormat,
      scrollDirection: scrollDirection??this.scrollDirection,
    );
  }

  @override
  // TODO: implement d
  DateTime get d => dateFormat;
}
