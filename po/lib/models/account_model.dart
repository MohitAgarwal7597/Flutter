// import 'package:hive/hive.dart';
import 'package:po/app/app_imports/app_imports.dart';
part 'account_model.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String number;

  @HiveField(2)
  String accountNumber;

  @HiveField(3)
  String cifNumber;

  @HiveField(4)
  DateTime openingDate;

  @HiveField(5)
  DateTime closingDate;

  @HiveField(6)
  String schemeType;

  @HiveField(7)
  double denomination;

  Account({
    required this.name,
    required this.number,
    required this.accountNumber,
    required this.cifNumber,
    required this.openingDate,
    required this.closingDate,
    required this.schemeType,
    required this.denomination,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'accountNumber': accountNumber,
      'cifNumber': cifNumber,
      'openingDate': openingDate.toIso8601String(),
      'closingDate': closingDate.toIso8601String(),
      'schemeType': schemeType,
      'denomination': denomination,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['name'],
      number: json['number'],
      accountNumber: json['accountNumber'],
      cifNumber: json['cifNumber'],
      openingDate: DateTime.parse(json['openingDate']),
      closingDate: DateTime.parse(json['closingDate']),
      schemeType: json['schemeType'],
      denomination: json['denomination'],
    );
  }
}
