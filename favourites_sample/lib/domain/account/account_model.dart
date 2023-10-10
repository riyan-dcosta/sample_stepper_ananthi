import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required String name,
    required String accountNumber,
    required String accountType,
    required String currencyCode,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}