import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipment_calendar/model/model.dart';

import '../model/sample_model.dart';
import '../service/service.dart';

final stepDataProvider = FutureProvider<List<SampleModel>>((ref) async {
  final stepDataService = ref.read(stepDataServiceProvider); // Get the StepDataService instance
  final jsonString = await stepDataService.loadStepDataJson(); // Call the method on the instance

  // Convert the JSON string to a List<dynamic>
  final List<dynamic> jsonData = json.decode(jsonString) as List<dynamic>;

  // Convert the List<dynamic> to a List<StepperData>
  List<SampleModel> stepDataList;
  stepDataList = jsonData.map((jsonMap) {
    return SampleModel.fromJson(jsonMap as Map<String, dynamic>);
  }).toList();

  return stepDataList;
});

final asyncValueProvider = Provider<AsyncValue<List<SampleModel>>>(
      (ref) => ref.watch(stepDataProvider),
);
