import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

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
        dateTime: DateTime.parse(data['dateTime']),
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
        return StepperEnum.authorized;
      case 'submitted':
        return StepperEnum.initiated;
      case 'inactive':
        return StepperEnum.returned;
      default:
        return StepperEnum.returned;
    }
  }
}

class HorizontalStepper extends StatefulWidget {
  final List<StepperData> steps;

  HorizontalStepper({required this.steps}) : super(key: UniqueKey());

  @override
  _HorizontalStepperState createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.steps.length,
            itemBuilder: (context, index) {
              return buildStep(index);
            },
          ),
        ),
      ],
    );
  }

  Widget buildStep(int index) {
    final step = widget.steps[index];
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              step.dateTime.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8.0),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: step.status == StepperEnum.returned
                        ? Colors.green
                        : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step.status == StepperEnum.returned
                        ? Icons.close
                        : Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                step.status == StepperEnum.returned
                    ? CustomPaint(
                  size: const Size(150, 2), // Adjust the size as needed
                  painter:
                  StepperLinesPainter(stepCount: widget.steps.length),
                )
                    : Container(
                  height: 2,
                  width: 150,
                  color: Colors.grey,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
            SizedBox(
              width: 150,
              child: Text(
                step.userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '(${step.userType})',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              step.status == StepperEnum.returned
                  ? 'Returned'
                  : step.status == StepperEnum.initiated
                  ? 'Success'
                  : 'Failure',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StepperLinesPainter extends CustomPainter {
  final int stepCount;

  StepperLinesPainter({required this.stepCount});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    final spaceBetweenCircles = size.width / (stepCount - 1);
    final circleRadius = size.height / 2;

    for (var i = 0; i < stepCount - 1; i++) {
      final x1 = (i + 0.5) * spaceBetweenCircles;
      final y1 = circleRadius;
      final x2 = (i + 1) * spaceBetweenCircles;
      final y2 = circleRadius;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Horizontal Stepper'),
        ),
        body: FutureBuilder<List<StepperData>>(
          future: StepDataService().loadStepData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available.'));
            } else {
              return HorizontalStepper(steps: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }
//
//
// class StepperLinesPainter extends CustomPainter {
//   final int stepCount;
//
//   StepperLinesPainter({required this.stepCount});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final linePaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2;
//
//     final circleRadius = 25.0;
//     final spaceBetweenCircles = size.width / (stepCount - 1);
//
//     // Draw the horizontal line
//     final lineY = size.height / 2;
//     canvas.drawLine(Offset(0, lineY), Offset(size.width, lineY), linePaint);
//
//     // Draw the circles
//     for (var i = 0; i < stepCount; i++) {
//       final x = i * spaceBetweenCircles;
//       final y = size.height / 2;
//
//       final circleCenter = Offset(x, y);
//       canvas.drawCircle(circleCenter, circleRadius, linePaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
