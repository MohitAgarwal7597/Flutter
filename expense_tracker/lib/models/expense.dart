import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
var formatter = DateFormat.yMd();

enum Category { travel, work, leisure, food }

const categoryIcons = {
  Category.travel: Icons.assist_walker,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.food: Icons.soup_kitchen,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
