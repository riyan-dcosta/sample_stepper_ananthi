class UserDataModel {
  final String? first_name;
  final String? last_name;
  final String? email;
  final int? id;
  final String? avatar;
  double? payAmount;

  UserDataModel({
    this.first_name,
    this.last_name,
    this.email,
    this.id,
    this.avatar,
    this.payAmount,
  });
}

class TotalAmountItem {
   double? totalAmount;
  final UserDataModel? user;

  TotalAmountItem({
    this.totalAmount,
    this.user,
  });
}
