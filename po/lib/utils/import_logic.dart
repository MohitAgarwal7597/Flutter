// import 'dart:convert';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:hive/hive.dart';
// import 'package:po/models/account_model.dart';
import 'package:po/app/app_imports/app_imports.dart';
Future<bool> importAccounts() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );

  if (result == null) return false; // user cancelled

  final file = File(result.files.single.path!);
  final jsonString = await file.readAsString();

  final List<dynamic> jsonList = jsonDecode(jsonString);
  final box = Hive.box<Account>('accounts');

  // Clear old data (optional)
  await box.clear();

  for (var jsonItem in jsonList) {
    final account = Account.fromJson(jsonItem);
    await box.add(account);
  }

  return true;
}
