import 'package:po/app/app_imports/app_imports.dart';
class AccountProvider with ChangeNotifier {
  List<Account> _accounts = [];
  List<Account> _filteredAccounts = [];
  List<Account> get filteredAccounts =>
      _filteredAccounts.isEmpty ? _accounts : _filteredAccounts;
  Future<void> loadAccounts() async {
    final box = Hive.box<Account>('accounts');
    _accounts = box.values.toList();
    _filteredAccounts = [];
    // notifyListeners();
  }

  void searchAccounts(String query) {
    if (query.trim().isEmpty) {
      _filteredAccounts = [];
    } else {
      _filteredAccounts = _accounts.where((account) {
        return account.name.toLowerCase().contains(query.toLowerCase()) ||
            account.accountNumber.contains(query);
      }).toList();
    }
    notifyListeners();
  }

  final Box<Account> _accountBox = Hive.box<Account>('accounts');

  List<Account> get accounts => _accountBox.values.toList();

  void addAccount(Account account) async {
    await _accountBox.add(account);
    notifyListeners();
  }
}
