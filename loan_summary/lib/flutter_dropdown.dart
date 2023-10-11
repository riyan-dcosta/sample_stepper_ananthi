import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropdownProvider = StateProvider<String>((ref) => loanData[0]['referenceNumber'].toString());

final dropdownProviderLoanType = StateProvider<String>((ref) => loanData[0]['loanType'].toString());
final dropdownProviderCurrency = StateProvider<String>((ref) => loanData[0]['currency'].toString());

final loanData = [
  {
    'referenceNumber': '123456789',
    'loanType': 'Home Loan',
    'currency': 'USD',
    'loanAmount': 100000,
    'interestRate': 5.0,
    'installmentPaid': 5000,
    'dghfds' : 73874,
  },
  {
    'referenceNumber': '987654321',
    'loanType': 'Car Loan',
    'currency': 'EUR',
    'loanAmount': 50000,
    'interestRate': 4.0,
    'installmentPaid': 2500,
    'dghfds' : 73874,
  },
  {
    'referenceNumber': '321456789',
    'loanType': 'Personal Loan',
    'currency': 'GBP',
    'loanAmount': 25000,
    'interestRate': 3.0,
    'installmentPaid': 1250,
    'dghfds' : 73874,
  },
];


class LoanSummary extends ConsumerWidget {
  const LoanSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValue = ref.watch(dropdownProvider);
    final dropdownValueLoanType = ref.watch(dropdownProviderLoanType);
    final dropdownValueCurrency = ref.watch(dropdownProviderCurrency);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 18,),
                DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: getAllReferenceNumbers(ref),
                    onChanged: (String? newValue) {
                      ref
                          .read(dropdownProvider.notifier)
                          .state = newValue!;
                    },
                  ),
                SizedBox(width: 28,),
                DropdownButton<String>(
                  value: dropdownValueLoanType,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: getAllLoanTypes(ref),
                  onChanged: (String? newValue) {
                    ref
                        .read(dropdownProviderLoanType.notifier)
                        .state = newValue!;
                  },
                ),
                SizedBox(width: 28,),
                DropdownButton<String>(
                  value: dropdownValueCurrency,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: getAllCurrencyCode(ref),
                  onChanged: (String? newValue) {
                    ref
                        .read(dropdownProviderCurrency.notifier)
                        .state = newValue!;
                  },
                ),
              ],
            ),
            Container(
              width: 200, // Adjust the width here
              child: TextField(
                decoration: InputDecoration(
             hintText: 'Search',
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(8.0),
             ),
             suffixIcon: IconButton(
               onPressed: () {
                 // Handle search button press here
                 // Perform the search operation
               },
               icon: Icon(Icons.search),
             ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DataTable(
                columns:  [
                  DataColumn(
                      label: Container(
                        constraints: BoxConstraints(
                          maxWidth: 154,// Adjust the maximum width of the cell
                          maxHeight: double.infinity, // Allow the cell to expand vertically
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Reference Number',softWrap: true, ),
                        ),
                      ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Loan Type',softWrap: true, ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 200.0),
                        child: Text('Currency'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Loan Amount'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Interest Rate',softWrap: true, ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Installment Paid'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('dghfds'),
                      ),
                    ),
                  ),
                ],
                rows: loanData.map((loan) {
                  return DataRow(
                    cells: [
                      DataCell(Text(loan['referenceNumber'].toString())),
                      DataCell(Text(loan['loanType'].toString())),
                      DataCell(Text(loan['currency'].toString())),
                      DataCell(Text(loan['loanAmount'].toString())),
                      DataCell(Text(loan['interestRate'].toString())),
                      DataCell(Text(loan['installmentPaid'].toString())),
                      DataCell(Text(loan['dghfds'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),


      ],
    );
  }
  List<DropdownMenuItem<String>> getAllReferenceNumbers(WidgetRef ref) {
    final List<DropdownMenuItem<String>> items = loanData
        .map((loan) => DropdownMenuItem<String>(
      value: loan['referenceNumber'].toString(),
      child: Text(loan['referenceNumber'].toString()),
    ))
        .toList();

    // Sort the list of items.
    items.sort((a, b) => a.value!.compareTo(b.value!));

    return items;
  }

  List<DropdownMenuItem<String>> getAllLoanTypes(WidgetRef ref) {
    final List<DropdownMenuItem<String>> items = loanData
        .map((loan) => DropdownMenuItem<String>(
      value: loan['loanType'].toString(),
      child: Text(loan['loanType'].toString()),
    ))
        .toList();

    // Sort the list of items.
    items.sort((a, b) => a.value!.compareTo(b.value!));

    return items;
  }

  List<DropdownMenuItem<String>> getAllCurrencyCode(WidgetRef ref) {
    final List<DropdownMenuItem<String>> items = loanData
        .map((loan) => DropdownMenuItem<String>(
      value: loan['currency'].toString(),
      child: Text(loan['currency'].toString()),
    ))
        .toList();

    // Sort the list of items.
    items.sort((a, b) => a.value!.compareTo(b.value!));

    return items;
  }
}