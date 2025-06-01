import 'package:intl/intl.dart';
import 'package:po/app/app_imports/app_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SortOption { name, maturity, amount }

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  String _searchQuery = '';
  Set<String> _selectedSchemes = {};
  bool _isFilterOpen = false;
  final TextEditingController _searchController = TextEditingController();
  SortOption _selectedSortOption = SortOption.name;

  @override
  void initState() {
    super.initState();
    Provider.of<AccountProvider>(context, listen: false).loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_isFilterOpen) {
            setState(() {
              _isFilterOpen = false;
            });
          }
        },
        child: Stack(
          children: [
            Scaffold(
              drawer: Drawer(
                // backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 4,
                // backgroundColor: Colors.white,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(Icons.settings,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 26),
                            const SizedBox(width: 10),
                            Text('Settings',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24)),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  size: 26),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 12),
                      _buildDrawerItem(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        subtitle: 'Notification History',
                        onTap: () {
                          context.push(AppRoutes.notificationScreen);
                          Navigator.of(context).pop();
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.file_upload_outlined,
                        title: 'Export Data',
                        subtitle: 'Backup your data to storage',
                        onTap: () => exportAccountData(),
                      ),
                      _buildDrawerItem(
                        icon: Icons.file_download_outlined,
                        title: 'Import Data',
                        subtitle: 'Restore data from a previous backup',
                        onTap: () => importAccounts(),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'For Personal User Only',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                title: _isSearching
                    ? TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Search by name or account number',
                          // filled: true,
                          // fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      )
                    : const Text(
                        'Account Manager Plus',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                actions: [
                  IconButton(
                    icon: Icon(_isSearching ? Icons.close : Icons.search),
                    onPressed: () {
                      setState(() {
                        if (_isSearching) {
                          _searchController.clear();
                          _searchQuery = '';
                        }
                        _isSearching = !_isSearching;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      setState(() {
                        _isFilterOpen = !_isFilterOpen;
                      });
                    },
                  ),
                  PopupMenuButton<SortOption>(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(40),
                    elevation: 2,
                    position: PopupMenuPosition.under,
                    icon: const Icon(Icons.sort),
                    onSelected: (SortOption option) {
                      setState(() {
                        _selectedSortOption = option;
                      });
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: SortOption.name,
                        child: Text('Name (A-Z)'),
                      ),
                      const PopupMenuItem(
                        value: SortOption.maturity,
                        child: Text('Maturity Date (Soonest First)'),
                      ),
                      const PopupMenuItem(
                        value: SortOption.amount,
                        child: Text('Amount (High to Low)'),
                      ),
                    ],
                  ),
                ],
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(.5),
                  dividerColor: Theme.of(context).colorScheme.onPrimary,
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  tabs: [
                    Tab(text: 'Active Accounts'),
                    Tab(text: 'Matured Accounts'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  AccountList(
                    isMatured: false,
                    searchQuery: _searchQuery,
                    selectedSchemes: _selectedSchemes,
                    sortOption: _selectedSortOption,
                  ),
                  AccountList(
                    isMatured: true,
                    searchQuery: _searchQuery,
                    selectedSchemes: _selectedSchemes,
                    sortOption: _selectedSortOption,
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAccountScreen()),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            if (_isFilterOpen)
              Positioned(
                top: kToolbarHeight + kTextTabBarHeight,
                right: 16,
                left: 16,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FutureBuilder<List<String>>(
                      future: _getUniqueSchemes(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final schemes = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: schemes.map((scheme) {
                            return CheckboxListTile(
                              title: Text(scheme),
                              value: _selectedSchemes.contains(scheme),
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    _selectedSchemes.add(scheme);
                                  } else {
                                    _selectedSchemes.remove(scheme);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> _getUniqueSchemes() async {
    final box = Hive.box<Account>('accounts');
    final schemes = box.values.map((e) => e.schemeType).toSet().toList();
    schemes.sort();
    return schemes;
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}

class AccountList extends StatelessWidget {
  final bool isMatured;
  final String searchQuery;
  final Set<String> selectedSchemes;
  final SortOption sortOption;

  const AccountList({
    super.key,
    required this.isMatured,
    required this.searchQuery,
    required this.selectedSchemes,
    required this.sortOption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: ValueListenableBuilder<Box<Account>>(
        valueListenable: Hive.box<Account>('accounts').listenable(),
        builder: (context, box, _) {
          final today = DateTime.now();

          final accounts = box.values.where((acc) {
            final matchesMaturity = isMatured
                ? acc.closingDate.isBefore(today)
                : acc.closingDate.isAfter(today);
            final matchesQuery = searchQuery.isEmpty ||
                acc.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                acc.accountNumber.contains(searchQuery);
            final matchesScheme = selectedSchemes.isEmpty ||
                selectedSchemes.contains(acc.schemeType);

            return matchesMaturity && matchesQuery && matchesScheme;
          }).toList();

          // Sorting
          accounts.sort((a, b) {
            switch (sortOption) {
              case SortOption.name:
                return a.name.toLowerCase().compareTo(b.name.toLowerCase());
              case SortOption.maturity:
                return a.closingDate.compareTo(b.closingDate);
              case SortOption.amount:
                return b.denomination.compareTo(a.denomination);
            }
          });

          if (accounts.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 400.h,
                      child: Image.asset('assets/images/zzz.png',
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text(
                      'No ${isMatured ? "matured" : "active"} records found.',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) =>
                AccountCard(account: accounts[index]),
          );
        },
      ),
    );
  }
}

void _showOptions(BuildContext context, Account account) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddAccountScreen(editAccount: account),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, account);
            },
          ),
        ],
      ),
    ),
  );
}

void _showDeleteConfirmation(BuildContext context, Account account) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Account'),
      content: const Text('Are you sure you want to delete this account?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            FlutterLocalNotificationsPlugin()
                .cancel(account.accountNumber.hashCode.abs());
            account.delete(); // Hive deletion
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

class AccountCard extends StatelessWidget {
  final Account account;
  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final daysLeft = account.closingDate.difference(DateTime.now()).inDays;
    final maturityText = daysLeft > 0
        ? 'Matures in $daysLeft days'
        : 'Matured ${-daysLeft} days ago';

    return GestureDetector(
      onLongPress: () => _showOptions(context, account),
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, size: 18),
                  SizedBox(width: 4.w),
                  Flexible(
                      child: Text(
                    account.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
                ],
              ),
              SizedBox(height: 4.h),
              Text('Account No: ${account.accountNumber}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      )),
              SizedBox(height: 4.h),
              Text('Cif No: ${account.cifNumber}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 4.h),
              Text(account.schemeType,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 15)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  spacing: 16.0.h,
                  runSpacing: 8.0.h,
                  children: [
                    Text(
                        'Opening Date: ${DateFormat.yMMMMd().format(account.openingDate)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 15)),
                    Text(
                        'Closing Date: ${DateFormat.yMMMMd().format(account.closingDate)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 15)),
                  ],
                ),
              ),
              Text('Mobile Number: ${account.number}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 14)),
              Divider(
                height: 16.h,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₹${account.denomination.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    maturityText,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
