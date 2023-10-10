import 'package:flutter/cupertino.dart';
import '../enum/enum.dart';

class StepperData {
  final DateTime dateTime;
  final String userName;
  final StatusColor status;
  final String userType;
  final IconData? icon;
  StepperData({
    required this.dateTime,
    required this.userName,
    required this.status,
    required this.userType,
    this.icon,
  });
}