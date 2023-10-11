import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:shipment_calendar/stepper_statring_stage.dart';

import 'enum/enum.dart';

class StepperData {
  final DateTime dateTime;
  final String userName;
  final StepperEnum status;
  final String userType;

  StepperData({
    required this.dateTime,
    required this.userName,
    required this.status,
    required this.userType,
  });
}

class StepDataService {
  Future<List<StepperData>> loadStepData() async {
    final jsonString = await rootBundle.loadString('assets/step_data.json');
    final jsonData = json.decode(jsonString);
    final List<StepperData> steps = [];

    for (var data in jsonData) {
      steps.add(StepperData(
        dateTime: data['name'],
        userName: data['name'],
        status: getStatusColorFromString(data['status']),
        userType: data['userType'],
      ));
    }

    return steps;
  }

  StepperEnum getStatusColorFromString(String status) {
    switch (status) {
      case 'active':
        return StepperEnum.initiated;
      case 'submitted':
        return StepperEnum.authorized;
      case 'inactive':
        return StepperEnum.released;
      default:
        return StepperEnum.returned;
    }
  }
}

class HorizontalStepper<T> extends StatelessWidget {
  final List<T> steps;

  const HorizontalStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Set your desired fixed height
      child: Card(
        elevation: 4, // Customize the elevation as needed
        margin: const EdgeInsets.all(16), // Add margin as needed
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int index = 0; index < steps.length; index++)
                buildStep(index, steps[index]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStep(int index, T step) {
    if (step == null) return const SizedBox(); // Check for null

    final StepperData data = step as StepperData;
    final dateFormat = DateFormat('MM/dd/yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Container(
      width: 200, // Adjust the width of each step card as needed
      margin: const EdgeInsets.all(8), // Add margin as needed
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: data.status == StepperEnum.returned
                      ? Colors.red
                      : Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data.status == StepperEnum.returned
                      ? Icons.close
                      : Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              index < steps.length - 1 && data.status == StepperEnum.returned
                  ? Container(
                      width: 150,
                      height: 1, // Adjust the height of the line as needed
                      child: CustomPaint(
                        painter: DottedLinePainter(),
                      ),
                    )
                  : Container(
                      width: 150,
                      height: 1, // Adjust the height of the line as needed
                      color: Colors.grey, // Set the color of the line
                    )
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            dateFormat.format(data.dateTime),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            timeFormat.format(data.dateTime),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  '${data.userName} (${data.userType})',
                  maxLines: 2, // Set the maximum number of lines
                  overflow: TextOverflow
                      .ellipsis, // Truncate with ellipsis if too long
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                EnumUtils.getStatusText(data.status),
                maxLines: 2, // Set the maximum number of lines
                overflow:
                    TextOverflow.ellipsis, // Truncate with ellipsis if too long
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*class StepperDataStepper extends HorizontalStepper<StepperData> {
  const StepperDataStepper({super.key, required super.steps});

  @override
  Widget buildStep(int index, StepperData step) {
    final formattedDate = DateTimeFormatter.customTimeFormatter(step.dateTime);
    final formattedTime = DateTimeFormatter.customTimeFormatter(step.dateTime);

    return Container(
      width: 200, // Adjust the width of each step card as needed
      margin: const EdgeInsets.all(8), // Add margin as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            formattedTime,
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: step.status == StatusColor.initiated
                      ? Colors.blue
                      : step.status == StatusColor.authorized
                          ? Colors.green
                          : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  step.status == StatusColor.initiated
                      ? Icons.check
                      : step.status == StatusColor.authorized
                          ? Icons.check
                          : Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              if (index < steps.length - 1 &&
                  (step.status == StatusColor.initiated ||
                      step.status == StatusColor.authorized))
                Container(
                  width: 150,
                  height: 1, // Adjust the height of the line as needed
                  color: Colors.grey, // Set the color of the line
                )
              else
                Container(
                  width: 150,
                  height: 1, // Adjust the height of the line as needed
                  child: CustomPaint(
                    painter: DottedLinePainter(),
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
                  '${step.userName} (${step.userType})',
                  maxLines: 5, // Set the maximum number of lines
                  overflow: TextOverflow
                      .ellipsis, // Truncate with ellipsis if too long
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
}*/

class DottedLinePainter extends CustomPainter {
  late Color color;
  late double strokeWidth;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const dashWidth = 5;
    const dashSpace = 5;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Horizontal Stepper'),
        ),
        body: FutureBuilder<List<StepperData>>(
          future: StepDataService().loadStepData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available.'));
            } else {
              return StepperDataStepper(steps: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}*/

class DateTimeFormatter {
  static String customDateFormatter(DateTime dateTime) {
    final date = DateFormat('MM/dd/yyyy').format(dateTime);
    return date;
  }

  static String customTimeFormatter(DateTime dateTime) {
    final time = DateFormat('MM/dd/yyyy').format(dateTime);
    return time;
  }
}

void main() {
  runApp(MyApp());
}
