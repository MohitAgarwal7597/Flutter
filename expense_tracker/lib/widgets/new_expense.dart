import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final Function(Expense) addExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  Category? selectCategory;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    final amount = double.tryParse(_amountController.text);
    final titleController = _titleController.text.trim();
    if (titleController.isEmpty ||
        amount == null ||
        amount <= 0 ||
        _selectedDate == null ||
        selectCategory == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Invalid Input "),
              content: const Text(
                "Please enter valid title, amount, and select date",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Okay"),
                ),
              ],
            ),
      );
      return;
    }
    widget.addExpense(
      Expense(
        title: titleController,
        amount: amount,
        date: _selectedDate!,
        category: selectCategory!,
      ),
    );
    Navigator.pop(context);
  }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    label: Text("Amount"),
                    prefixText: '\u20B9',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Select Date"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                dropdownColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.primaryContainer
                        : const Color.fromARGB(255, 244, 244, 244),
                style: TextStyle(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors
                              .white // White text in dark mode
                          : Colors.black,
                ), // Black text in light mode
                // style: TextStyle(color: Colors.white),
                value: selectCategory,
                hint: Text("Select Category"),
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancle"),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpense();
                },
                child: Text("Add Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
