import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shipment_calendar/main.dart';

import '../enum/enum.dart';

class StepperData2 {
  final String userType;
  final String name;
  final String dateTime;
  final StepperEnum status;
  final Color stepperColor;
  final Color stepperLine;
  final String statusText;

  StepperData2({
    required this.userType,
    required this.name,
    required this.dateTime,
    required this.status,
    required this.stepperColor,
    required this.stepperLine,
    required this.statusText,
  });

  StepperData2 copyWith({
    String? userType,
    String? name,
    String? dateTime,
    StepperEnum? status,
    Color? stepperColor,
    Color? stepperLine,
    String? statusText,
  }) {
    return StepperData2(
      userType: userType ?? this.userType,
      name: name ?? this.name,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      stepperColor: stepperColor ?? this.stepperColor,
      stepperLine: stepperLine ?? this.stepperLine,
      statusText: statusText ?? this.statusText,
    );
  }

  factory StepperData2.fromJson(Map<String, dynamic> jsonData) {
    final statusText =
        EnumUtils.getStatusText(jsonData['status'] as StepperEnum);
    return StepperData2(
      userType: jsonData['userType'] as String,
      name: jsonData['name'] as String,
      dateTime: jsonData['dateTime'] as String,
      status: jsonData['status'] as StepperEnum,
      stepperColor: jsonData['status'] == 'Returned'
          ? Colors.pinkAccent.shade100
          : Colors.green,
      stepperLine: jsonData['status'] == 'Returned' ? Colors.red : Colors.grey,
      statusText: statusText,
    );
  }
}

class TestGeneric extends StepperDataHolder {
  TestGeneric({
    required super.dateFormat,
    required super.timeFormat,
    required super.scrollDirection,
    required super.status,
  });

  @override
  DateTime get d => dateFormat;
}
