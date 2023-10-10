import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shipment_calendar/model/model.dart';
import 'package:shipment_calendar/provider/provider.dart';
import 'common_widget/dotted_line.dart';
import 'common_widget/widget_value_loader.dart';
import 'date_format/date_-format.dart';
import 'enum/enum.dart';

class StepperDataHolder<T> {
  final List<T> stepperHolder;
  final DateTime dateFormat;
  final DateTime timeFormat;
  final Axis scrollDirection;
  final String? name;
  final String? userType;
  StepperDataHolder({
    required this.stepperHolder,
    required this.dateFormat,
    required this.timeFormat,
    required this.scrollDirection,
    this.name,
    this.userType,
  });
}

class HorizontalStepper<T extends StepperData> extends StatelessWidget {
  final List<T> steps;
  final StepperDataHolder<T> stepperDataHolder;

  const HorizontalStepper({
    Key? key,
    required this.steps,
    required this.stepperDataHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: stepperDataHolder.scrollDirection,
        itemCount: steps.length,
        itemBuilder: (BuildContext context, int index) {
          return buildStep(index, steps[index]);
        },
      ),
    );
  }

  Widget buildStep(int index, T stepHolder) {
    final bool isLastStep = index == steps.length - 1;
    final bool isReturned = stepHolder.status == StatusColor.returned;

    if (stepHolder == null) {
      return Container(); // Handle null stepHolder case
    }

    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateTimeFormatter.customDateFormatter(stepHolder.dateTime),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            DateTimeFormatter.customTimeFormatter(stepHolder.dateTime),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: stepHolder
                      .status.stepperColor, // Use the extension method
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stepHolder.status.icon
                      as IconData?, // Use the extension method
                  color: Colors.white,
                  size: 30,
                ),
              ),
              // Conditionally show the grey line at the bottom
              if (isLastStep && !isReturned)
                Container(
                  width: 150,
                  height: 1, // Adjust the height of the line as needed
                  color: Colors.grey, // Set the color of the line
                ),
              // Conditionally show the dotted line for "returned" status
              if (isReturned)
                Container(
                  width: 2,
                  height: 3,
                  child: CustomPaint(
                    painter: DottedLinePainter(
                      color: Colors.red,
                      strokeWidth: 2,
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  '${stepHolder.userName ?? ''} (${stepHolder.userType ?? ''})', // Add a null check for both name and userType
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget Mybuild(BuildContext context) {
  final String name = 'John Doe';
  final String userType = 'Customer';

  return SafeArea(
    child: Scaffold(
      body: Center(
        child: WidgetValueLoader<List<StepperData>>(
          value: stepDataProvider,
          data: (stepperDataList) {
            return HorizontalStepper(
              steps: stepperDataList,
              stepperDataHolder: StepperDataHolder(
                stepperHolder: stepperDataList,
                dateFormat: stepperDataList[0].dateTime,
                // Pass the dateFormat value from the first element of the list
                timeFormat: stepperDataList[0].dateTime,
                // Pass the timeFormat value from the first element of the list
                scrollDirection: Axis.horizontal,
                name: name,
                userType: userType,
              ),
            );
          },
          loadingBuilder: () => const CircularProgressIndicator(),
          errorBuilder: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
    ),
  );
}

void main() {
  runApp(MaterialApp(
    home: Mybuild(context as BuildContext),
  ));
}