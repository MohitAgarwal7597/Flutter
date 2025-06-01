import 'package:intl/intl.dart';
import 'package:po/app/app_imports/app_imports.dart';

class AddAccountScreen extends StatefulWidget {
  final Account? editAccount;
  const AddAccountScreen({super.key, this.editAccount});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  Future<void> saveNotificationToHive(
      LocalNotificationModel notification) async {
    final box = Hive.box<LocalNotificationModel>('notifications');
    await box.add(notification);
  }

  var scheme;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _cifController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _openingDate = DateTime.now();
  DateTime? _maturityDate;
  String? _selectedScheme;

  @override
  void initState() {
    super.initState();
    if (widget.editAccount != null) {
      final acc = widget.editAccount!;
      _nameController.text = acc.name;
      _numberController.text = acc.number;
      _accountNumberController.text = acc.accountNumber;
      _cifController.text = acc.cifNumber;
      _amountController.text = acc.denomination.toString();
      _openingDate = acc.openingDate;
      _maturityDate = acc.closingDate;
      _selectedScheme = acc.schemeType;
    }
  }

  Future<void> _pickDate(BuildContext context, bool isOpeningDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isOpeningDate) {
          _openingDate = picked;
        } else {
          _maturityDate = picked;
        }
      });
    }
  }

  void updateMaturityDate(String scheme) {
    if (scheme == 'National Savings Certificate (NSC)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 1825));
      });
    }
    if (scheme == 'Monthly Income Scheme (MIS)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 1825));
      });
    }
    if (scheme == 'Kisan Vikas Patra (KVP)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 3285 + 213));
      });
    }
    if (scheme == 'Recurring Deposit (RD)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 1825));
      });
    }
    if (scheme == 'Time Deposit - 1 Year (TD 1 Year)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 365));
      });
    }
    if (scheme == 'Time Deposit - 2 Years (TD 2 Years)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 730));
      });
    }
    if (scheme == 'Time Deposit - 3 Years (TD 3 Years)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 1095));
      });
    }
    if (scheme == 'Time Deposit - 5 Years (TD 5 Years)') {
      setState(() {
        _maturityDate = _openingDate!.add(const Duration(days: 1825));
      });
    }
  }

  Future<void> _pickMaturityDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );
    if (picked != null) {
      setState(() {
        _maturityDate = picked;
      });
    }
  }

  void _saveAccount() async {
    // Helper to schedule notifications for an account
    Future<void> _scheduleNotifications({
      required String accountNumber,
      required String name,
      required String amount,
      required String schemeType,
      required int id,
      required DateTime maturityDate,
    }) async {
      await NotificationService.scheduleMaturityNotification(
        accountNumber: accountNumber,
        name: name,
        amount: amount,
        schemeType: schemeType,
        id: id,
        title: 'Account Maturity Reminder',
        body: 'Account for $name matures in 7 days!',
        maturityDate: maturityDate,
      );
      await NotificationService.scheduleMaturityNotificationTwo(
        accountNumber: accountNumber,
        name: name,
        amount: amount,
        schemeType: schemeType,
        id: id,
        title: 'Account Maturity Reminder',
        body: 'Account for $name matures in 3 days!',
        maturityDate: maturityDate,
      );
      await NotificationService.scheduleMaturityNotificationThree(
        accountNumber: accountNumber,
        name: name,
        amount: amount,
        schemeType: schemeType,
        id: id,
        title: 'Account Maturity Reminder',
        body: 'Account for $name matures in 1 day!',
        maturityDate: maturityDate,
      );
    }

    if (widget.editAccount != null) {
      // Update existing account
      final account = widget.editAccount!
        ..name = _nameController.text.trim()
        ..number = _numberController.text.trim()
        ..accountNumber = _accountNumberController.text.trim()
        ..cifNumber = _cifController.text.trim()
        ..openingDate = _openingDate!
        ..closingDate = _maturityDate!
        ..schemeType = _selectedScheme!
        ..denomination = double.tryParse(_amountController.text.trim()) ?? 0.0;

      await account.save();

      // Cancel old notification
      await FlutterLocalNotificationsPlugin()
          .cancel(account.accountNumber.hashCode.abs());

      // Schedule updated notifications
      try {
        await _scheduleNotifications(
          accountNumber: account.accountNumber,
          name: account.name,
          amount: _amountController.text.trim(),
          schemeType: account.schemeType.toString(),
          id: account.accountNumber.hashCode.abs(),
          maturityDate: _maturityDate!,
        );
      } catch (e, stack) {
        print('Error scheduling notifications: $e\n$stack');
      }

      // Show toast
      DelightToastBar.removeAll();
      DelightToastBar(
        autoDismiss: true,
        snackbarDuration: Duration(seconds: 5),
        animationDuration: Duration(milliseconds: 1500),
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: Theme.of(context).colorScheme.onPrimary,
          subtitle: Text('Swipe To Dismiss!',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          leading: Icon(Icons.flutter_dash,
              color: Theme.of(context).colorScheme.primary, size: 28),
          trailing: IconButton(
            onPressed: DelightToastBar.removeAll,
            icon: Icon(Icons.cancel_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          title: Text('Updated Account!',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700)),
        ),
      ).show(context);

      if (!mounted) return;
      Navigator.pop(context);
    } else if (_formKey.currentState!.validate() &&
        _openingDate != null &&
        _maturityDate != null &&
        _selectedScheme != null) {
      // Add new account
      final account = Account(
        name: _nameController.text.trim(),
        number: _numberController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        cifNumber: _cifController.text.trim().isEmpty
            ? 'Not Available'
            : _cifController.text.trim(),
        openingDate: _openingDate!,
        closingDate: _maturityDate!,
        schemeType: _selectedScheme!,
        denomination: double.tryParse(_amountController.text.trim()) ?? 0.0,
      );

      final box = Hive.box<Account>('accounts');
      await box.add(account);

      // Generate unique ID for new notifications
      final notificationId = account.accountNumber.hashCode.abs();

      try {
        await _scheduleNotifications(
          accountNumber: account.accountNumber,
          name: account.name,
          amount: _amountController.text.trim(),
          schemeType: account.schemeType.toString(),
          id: notificationId,
          maturityDate: _maturityDate!,
        );
      } catch (e, stack) {
        print('Error scheduling notifications: $e\n$stack');
      }

      await saveNotificationToHive(LocalNotificationModel(
        title: account.name,
        body: '${account.schemeType}\nDenomination: ${account.denomination}',
        date: DateTime.now(),
      ));

      // Show toast
      DelightToastBar.removeAll();
      DelightToastBar(
        autoDismiss: true,
        snackbarDuration: Duration(seconds: 5),
        animationDuration: Duration(milliseconds: 1500),
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          color: Theme.of(context).colorScheme.primary,
          subtitle: Text('Swipe To Dismiss!',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          leading: Icon(Icons.flutter_dash,
              color: Theme.of(context).colorScheme.onPrimary, size: 28),
          trailing: IconButton(
            onPressed: DelightToastBar.removeAll,
            icon: Icon(Icons.cancel_outlined,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          title: Text('Add New Account!',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w700)),
        ),
      ).show(context);

      if (!mounted) return;
      Navigator.of(context).pop();

      print('Notification Scheduled');
    }
  }

  // await NotificationService.scheduleMaturityNotifications(
  //   1,
  //   'Test Account',
  //   DateTime.now().add(Duration(days: 60)), // dummy future maturity
  //   debug:
  //       true, // <-- triggers notifications after 1, 7, 30 minutes instead of days
  // );

  // await NotificationService.scheduleMaturityNotifications(
  //   int.parse(_accountNumberController.text.trim()),
  //   _nameController.text.trim(),
  //   _maturityDate!,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Account')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      labelText: 'Account Holder Name*',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                      counterStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      labelText: 'Mobile Number*',
                      labelStyle: TextStyle(color: Colors.black)),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) => value!.length == 10
                      ? null
                      : 'Enter valid 10-digit number',
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                      counterStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      labelText: 'Account Number*',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _cifController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      labelText: 'CIF Number(Optional)',
                      labelStyle: TextStyle(color: Colors.black)),
                  // validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: _selectedScheme,
                  decoration: const InputDecoration(
                    // focusColor: Colors.black,
                    // filled: true,
                    // fillColor: Colors.white,
                    // border: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(16))
                    // ),
                    labelText: 'Scheme Type*',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  isExpanded: true,
                  items: SchemeList.schemeList
                      .map((scheme) => DropdownMenuItem(
                          value: scheme,
                          child: Text(
                            scheme,
                            overflow: TextOverflow.ellipsis,
                          )))
                      .toList(),
                  onChanged: (value) => setState(() {
                    _selectedScheme = value;
                    updateMaturityDate(_selectedScheme!);
                  }),
                  validator: (value) => value == null ? 'Required' : null,
                ),
                ListTile(
                  title: Text(
                    _openingDate == null
                        ? 'Opening Date*'
                        : DateFormat.yMMMMd().format(_openingDate!),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () => _pickDate(context, true),
                ),
                ListTile(
                  title: Text(
                    _maturityDate == null
                        ? 'Maturity Date*(Auto Update)'
                        : DateFormat.yMMMMd().format(_maturityDate!),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () => _pickMaturityDate(context),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      labelText: 'Deposit Amount*',
                      labelStyle: TextStyle(color: Colors.black)),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      _saveAccount();
                    },
                    label: Text(
                      widget.editAccount != null
                          ? 'Update Account'
                          : 'Add Account',
                      style: TextStyle(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
