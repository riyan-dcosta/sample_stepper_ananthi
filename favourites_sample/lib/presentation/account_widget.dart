import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/account/account_model.dart';
import '../service/account_service.dart';




class AccountWidget extends ConsumerWidget {
  const AccountWidget({Key? key}) : super(key: key);

  final List<String> menuLists = ['Account', 'Favorites'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final totalAmountItem = ref.watch(totalAmountItemListStateNotifierProvider);

    double? totalAmount = totalAmountItem.totalAmount;
    final accountValues = ref.watch(accountListFutureProvider);
    final selectedMenu = ref.watch(accountCategoryProvider);

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                  offset: const Offset(-40, 60),
                  initialValue: selectedMenu,
                  itemBuilder: (BuildContext context) {
                    return [
                      // ... Popup menu items ...
                    ];
                  },
                  // ... Popup menu onSelected ...
                ),
              ),
              // ... Other UI components ...

              if (selectedMenu == 'Account')
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Select')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Id')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Avatar')),
                    DataColumn(label: Text('Pay Amount')),
                  ],
                  rows: accountValues.when(
                    data: (accountList) {
                      return accountList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final account = entry.value;
                        final itemWithPayAmount = itemListState[index];

                        return DataRow(cells: [
                          DataCell(
                            Checkbox(
                              value: itemWithPayAmount.payAmount != 0,
                              onChanged: (value) {
                                ref.read(totalAmountItemListStateNotifierProvider.notifier).updateTotalAmount(index, value ? initialPayAmounts[index] : 0);
                              },
                            ),
                          ),
                          DataCell(Text(account.first_name.toString())),
                          DataCell(Text(account.last_name.toString())),
                          DataCell(Text(account.id.toString())),
                          DataCell(Text(account.email.toString())),
                          DataCell(Image.network(account.avatar)),
                          DataCell(Text(initialPayAmounts[index].toString())),
                        ]);
                      }).toList();
                    },
                      loading: () =>
                      [
                        const DataRow(cells: [
                          DataCell(Text('Loading...')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ],
                      error: (error, stackTrace) =>
                      [
                        DataRow(cells: [
                          DataCell(
                            Text(
                              'Error: $error',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          const DataCell(Text('')),
                          const DataCell(Text('')),
                        ]),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
    );
  }


}