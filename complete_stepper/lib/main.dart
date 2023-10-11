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

  StepperDataHolder({
    required this.dateFormat,
    required this.timeFormat,
    required this.scrollDirection,
    this.name,
    this.userType,
    required this.status,
  });
}


class GenericStepper<T extends StepperDataHolder<SampleModel>> extends StatelessWidget {
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
  const GenericStepper({Key? key, required this.steps, required this.dateFormat, required this.timeFormat, required this.scrollDirection, this.name, this.userType, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (BuildContext context, int index) {
          final step = steps[index];
          return buildStep(step);
        },
      ),
    );
  }

  Widget buildStep(T stepHolder) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepHolder.dateFormat.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            stepHolder.timeFormat.toString(),
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
                  color: stepHolder.status.stepperColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stepHolder.status.icon,
                  color: stepHolder.status.iconColor,
                  size: 30,
                ),
              ),
              Container(
                width: 150,
                height: 1,
                color: stepHolder.status.stepperLine,
              ),
            ],
          ),
          // Customize the rest of your UI elements here based on your data
        ],
      ),
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
            steps: data, dateFormat: , timeFormat: null, scrollDirection: null, status: null,
          );
        },
        loadingBuilder: () => const CircularProgressIndicator(),
        errorBuilder: (error, stackTrace) => Text('Error: $error'),
      ),
    );
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
