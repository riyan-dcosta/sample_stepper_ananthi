import 'package:flutter/material.dart';

import '../main.dart';

class SampleModel {
  final String userType;
  final String name;
  final DateTime dateTime;
  final String status;
  final Color stepperColor;
  final Color stepperLine;
  final String statusText;
  final int someIntValue;
  final DateTime someDateTimeValue;
  final bool someBoolValue;

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
  });

  factory SampleModel.fromJson(Map<String, dynamic> jsonData) {
    return SampleModel(
      userType: jsonData['userType'] as String,
      name: jsonData['name'] as String,
      dateTime: DateTime.parse(jsonData['dateTime'] as String),
      status: jsonData['status'] as String,
      stepperColor: Color(int.parse(jsonData['stepperColor'].substring(1, 7), radix: 16) + 0xFF000000),
      stepperLine: Color(int.parse(jsonData['stepperLine'].substring(1, 7), radix: 16) + 0xFF000000),
      statusText: jsonData['statusText'] as String,
      someIntValue: jsonData['someIntValue'] as int,
      someDateTimeValue: DateTime.parse(jsonData['someDateTimeValue'] as String),
      someBoolValue: jsonData['someBoolValue'] as bool,
    );
  }

  SampleModel copyWith({
    String? userType,
    String? name,
    DateTime? dateTime,
    String? status,
    Color? stepperColor,
    Color? stepperLine,
    String? statusText,
    int? someIntValue,
    DateTime? someDateTimeValue,
    bool? someBoolValue,
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
    );
  }
}
