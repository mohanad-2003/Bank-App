import 'package:banking_app/features/transaction_report/providers/transaction_report_provider.dart';
import 'package:banking_app/features/transaction_report/widgets/report_balance_card.dart';
import 'package:banking_app/features/transaction_report/widgets/report_card_preview.dart';
import 'package:banking_app/features/transaction_report/widgets/report_header.dart';
import 'package:banking_app/features/transaction_report/widgets/transaction_history_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionReportScreen extends ConsumerWidget {
  const TransactionReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(transactionReportCardProvider);
    final balance = ref.watch(transactionBalanceProvider);
    final chartItems = ref.watch(reportChartProvider);
    final history = ref.watch(transactionHistoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      12,
                      horizontalPadding,
                      110,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff4338D8),
                    ),
                    child: const ReportHeader(),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -78),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        children: [
                          ReportCardPreview(card: card),
                          const SizedBox(height: 26),
                          ReportBalanceCard(
                            balance: balance,
                            chartItems: chartItems,
                          ),
                          const SizedBox(height: 20),
                          ListView.separated(
                            itemCount: history.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (_, __) => const SizedBox(height: 18),
                            itemBuilder: (context, index) {
                              final item = history[index];
                              final showTitle = index == 0 ||
                                  history[index - 1].sectionTitle !=
                                      item.sectionTitle;

                              return TransactionHistoryTile(
                                item: item,
                                showSectionTitle: showTitle,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}