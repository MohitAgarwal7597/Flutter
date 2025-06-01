// import 'dart:convert';
// import 'dart:io';
// import 'package:external_path/external_path.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:hive/hive.dart';
// import '../models/account_model.dart';
import 'package:po/app/app_imports/app_imports.dart';
Future<void> exportAccountData() async {
  final status = await Permission.manageExternalStorage.request();

  if (!status.isGranted) {
    print('❌ Storage permission denied');
    return;
  }

  try {
    // ✅ Ensure the box is open before accessing it
    final box = Hive.isBoxOpen('accounts')
        ? Hive.box<Account>('accounts')
        : await Hive.openBox<Account>('accounts');
    print('📦 Total accounts: ${box.length}');

    final accounts = box.values.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(accounts);

    final downloadsPath = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOAD,
    );

    final file = File(
        '$downloadsPath/post_office_backup_${DateTime.now().millisecondsSinceEpoch}.json');

    await file.writeAsString(jsonString);
    print('✅ Exported to: ${file.path}');

    // Optional: Share the file after writing
    await Share.shareXFiles([XFile(file.path)],
        text: '📁 Post Office backup file');
  } catch (e) {
    print('❌ Export error: $e');
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:hive/hive.dart';
// import 'package:po/models/account_model.dart';

// Future<String?> exportAccounts() async {
//   final box = Hive.box<Account>('accounts');
//   final List<Map<String, dynamic>> accounts = box.values
//       .map((account) => account.toJson()) // Implement toJson() in Account model
//       .toList();

//   final jsonString = jsonEncode(accounts);

//   if (!(await _requestPermission())) return null;

//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/postoffice_accounts_backup.json');

//   await file.writeAsString(jsonString);

//   return file.path; // Return path of saved backup file
// }

// Future<bool> _requestPermission() async {
//   final status = await Permission.storage.request();
//   return status.isGranted;
// }
