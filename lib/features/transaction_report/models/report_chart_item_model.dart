class ReportChartItemModel {
  final String month;
  final double incomeHeight;
  final double expenseHeight;
  final bool isSelected;

  const ReportChartItemModel({
    required this.month,
    required this.incomeHeight,
    required this.expenseHeight,
    this.isSelected = false,
  });
}