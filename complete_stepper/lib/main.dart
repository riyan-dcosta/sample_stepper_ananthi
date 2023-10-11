import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipment_calendar/common_widget/widget_value_loader.dart';
import 'package:shipment_calendar/model/sample_model.dart';
import 'package:shipment_calendar/provider/provider.dart';
import 'enum/enum.dart';

// Define your StepperData class and other imports

abstract class StepperDataHolder<T> {
  final DateTime dateFormat;
  final DateTime timeFormat;
  final Axis scrollDirection;
  final String? name;
  final String? userType;
  final StepperEnum status;

  DateTime get d => dateFormat;

  // final StepperEnum status;

  StepperDataHolder({
    required this.dateFormat,
    required this.timeFormat,
    required this.scrollDirection,
    this.name,
    this.userType,
    required this.status,
  });
}

class GenericStepper<T extends StepperDataHolder> extends StatefulWidget {
  final List<T> steps;

  @override
  final DateTime dateFormat;

  @override
  final DateTime timeFormat;

  @override
  final Axis scrollDirection;

  @override
  final String? name;

  @override
  final String? userType;

  @override
  final StepperEnum status;

  const GenericStepper(
      {Key? key,
      required this.steps,
      required this.dateFormat,
      required this.timeFormat,
      required this.scrollDirection,
      this.name,
      this.userType,
      required this.status})
      : super(key: key);

  @override
  State<GenericStepper<T >> createState() =>
      _GenericStepperState<T >();
}

class _GenericStepperState<T extends StepperDataHolder> extends
State<GenericStepper<T >> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: widget.steps.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final step = widget.steps[index];
          return buildStep(index, step);
        },
      ),
    );
  }

  Widget buildStep(int index, T step) {
    // final step = widget.steps[index];
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              step.dateFormat.toString(),
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
                        ? Colors.red
                        : Colors.green,
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
                "${step.userType}",
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

class Sample extends StatelessWidget {
  const Sample({Key? key});

  @override
  Widget build(BuildContext context) {
    final asyncValueProvider = Provider<AsyncValue<List<SampleModel>>>(
      (ref) => ref.watch(stepDataProvider),
    );

    return ProviderScope(
      child: WidgetValueLoader(
        value: asyncValueProvider,
        data: (data) {
          return GenericStepper<SampleModel>(
            steps: data,
            dateFormat: DateTime.now(),
            timeFormat: DateTime.now(),
            scrollDirection: Axis.horizontal,
            status: StepperEnum.authorized,
          );
        },
        loadingBuilder: () => const CircularProgressIndicator(),
        errorBuilder: (error, stackTrace) => Text('Error: $error'),
      ),
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

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Sample(),
      ),
    ),
  ));
}
