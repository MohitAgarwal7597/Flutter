import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpense: _addNewExpense),
    );
  }

  final List<Expense> _list = [
    Expense(
      title: "Dummy Expense Delete It!",
      amount: 499.00,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _list.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    int currentIndex = _list.indexOf(expense);
    setState(() {
      _list.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        content: Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _list.insert(currentIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No Expenses Found Try Adding Some!"),
    );
    if (_list.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _list,
        removeExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: openAddExpenseOverlay),
        ],
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _list),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _list)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
