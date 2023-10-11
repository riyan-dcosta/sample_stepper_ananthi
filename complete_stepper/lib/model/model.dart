import 'dart:ui';

import 'package:flutter/material.dart';

import '../enum/enum.dart';

class StepperData {
  final String userType;
  final String name;
  final String dateTime;
  final StepperEnum status;
  final Color stepperColor;
  final Color stepperLine;
  final String statusText;

  StepperData({
    required this.userType,
    required this.name,
    required this.dateTime,
    required this.status,
    required this.stepperColor,
    required this.stepperLine,
    required this.statusText,
  });

  StepperData copyWith({
    String? userType,
    String? name,
    String? dateTime,
    StepperEnum? status,
    Color? stepperColor,
    Color? stepperLine,
    String? statusText,
  }) {
    return StepperData(
      userType: userType ?? this.userType,
      name: name ?? this.name,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      stepperColor: stepperColor ?? this.stepperColor,
      stepperLine: stepperLine ?? this.stepperLine,
      statusText: statusText ?? this.statusText,
    );
  }

  factory StepperData.fromJson(Map<String, dynamic> jsonData) {
    final statusText = EnumUtils.getStatusText(jsonData['status'] as StepperEnum);
    return StepperData(
      userType: jsonData['userType'] as String,
      name: jsonData['name'] as String,
      dateTime: jsonData['dateTime'] as String,
      status: jsonData['status'] as StepperEnum,
      stepperColor: jsonData['status'] == 'Returned' ? Colors.pinkAccent.shade100 : Colors.green,
      stepperLine: jsonData['status'] == 'Returned' ? Colors.red : Colors.grey,
      statusText: statusText,
    );
  }
}
