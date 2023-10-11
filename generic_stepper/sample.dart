// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shipment_calendar/enum/enum.dart';
// import 'package:shipment_calendar/main.dart';
//
// class StepperStatus {
//   final List<StepperData> stepperStatus;
//
//   StepperStatus({
//     required this.stepperStatus,
//   });
// }
//
// class HorizontalStepper<T> extends StatelessWidget {
//   final List<T> steps;
//   final StepperStatus stepperStatus;
//   final DateFormat dateFormat;
//   final DateFormat timeFormat;
//   final List<Color> stepColors;
//   final List<IconData> stepIcons;
//   final List<double> stepIconSizes;
//   final List<String> stepLabels;
//   final double stepWidth;
//   final double stepHeight;
//   final double stepLineHeight;
//   final Color stepLineColor;
//   final double stepLineWidth;
//   final Axis scrollDirection;
//   final IconData rejectedStepIcon; // Add parameter for rejected step icon
//   final Color color;
//   final double strokeWidth;
//
//   const HorizontalStepper({
//     Key? key,
//     required this.steps,
//     required this.stepperStatus,
//     required this.dateFormat,
//     required this.timeFormat,
//     required this.stepColors,
//     required this.stepIcons,
//     required this.stepIconSizes,
//     required this.stepLabels,
//     required this.stepWidth,
//     required this.stepHeight,
//     required this.stepLineHeight,
//     required this.stepLineColor,
//     required this.stepLineWidth,
//     required this.scrollDirection,
//     required this.rejectedStepIcon, // Specify the icon for rejected steps
//     required this.color, // Specify the icon for rejected steps
//     required this.strokeWidth, // Specify the icon for rejected steps
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: stepHeight,
//       child: Card(
//         elevation: 4,
//         margin: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           scrollDirection: scrollDirection,
//           child: ListView.builder(
//             scrollDirection: scrollDirection,
//             itemCount: steps.length,
//             itemBuilder: (context, index) {
//               return buildStep(
//                 index,
//                 steps[index],
//                 stepperStatus.stepperStatus[index],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildStep(int index, T step, StepperData stepperData) {
//     if (step == null) return const SizedBox();
//
//     return Container(
//       width: stepWidth,
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//        /*   Text(
//             customDateFormatter(stepperData.dateTime),
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             customTimeFormatter(stepperData.dateTime),
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 8.0),*/
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: stepIconSizes[index],
//                 height: stepIconSizes[index],
//                 decoration: BoxDecoration(
//                   color: stepColors[index],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   stepIcons[index],
//                   color: Colors.white,
//                   size: stepIconSizes[index],
//                 ),
//               ),
//               if (index < steps.length - 1 &&
//                   (stepperData.status == StepperEnum.initiated ||
//                       stepperData.status == StepperEnum.authorized))
//                 Container(
//                   width: stepLineHeight,
//                   height: stepLineHeight,
//                   color: stepLineColor,
//                 )
//               else
//                 Container(
//                   width: stepLineHeight,
//                   height: stepLineHeight,
//                   child: CustomPaint(
//                     painter: DottedLinePainter1(
//                       color: stepLineColor,
//                       strokeWidth: stepLineWidth,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//          /* Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 140,
//                 child: Text(
//                   '${stepperData.userName} (${stepperData.userType})',
//                   maxLines: 5,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),*/
//         ],
//       ),
//     );
//   }
// }
//
// String customDateFormatter(DateTime dateTime) {
//   // Format the date as "MM/dd/yyyy"
//   return DateFormat('MM/dd/yyyy').format(dateTime);
// }
//
// String customTimeFormatter(DateTime dateTime) {
//   // Format the time as "hh:mm a"
//   return DateFormat('hh:mm a').format(dateTime);
// }
//
// class DottedLinePainter1 extends CustomPainter {
//   final Color color;
//   final double strokeWidth;
//
//   DottedLinePainter1({
//     required this.color,
//     required this.strokeWidth,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;
//
//     const dashWidth = 5;
//     const dashSpace = 5;
//     double startY = 0;
//
//     while (startY < size.height) {
//       canvas.drawLine(
//         Offset(0, startY),
//         Offset(0, startY + dashWidth),
//         paint,
//       );
//       startY += dashWidth + dashSpace;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
