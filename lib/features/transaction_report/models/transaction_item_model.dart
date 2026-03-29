import 'package:flutter/material.dart';

class TransactionItemModel {
  final String sectionTitle; // Today / Yesterday
  final String title;        // عنوان العملية
  final String status;       // Successfully / Unsuccessfully
  final String amount;       // +$1200 / -$280
  final IconData icon;       // أيقونة العملية
  final Color iconBgColor;   // خلفية الأيقونة
  final bool isIncome;       // اذا كانت اضافة ام خصم

  const TransactionItemModel({
    required this.sectionTitle,
    required this.title,
    required this.status,
    required this.amount,
    required this.icon,
    required this.iconBgColor,
    this.isIncome = false,
  });
}