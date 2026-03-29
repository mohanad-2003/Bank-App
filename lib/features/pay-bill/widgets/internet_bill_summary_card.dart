import 'package:banking_app/features/pay-bill/models/internet_bill_model.dart';
import 'package:flutter/material.dart';

class InternetBillSummaryCard extends StatelessWidget {
  const InternetBillSummaryCard({
    super.key,
    required this.bill,
    this.showTopImage = false,
    this.imagePath,
    this.dateRange,
  });

  final InternetBillModel bill;
  final bool showTopImage;
  final String? imagePath;
  final String? dateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          if (showTopImage && imagePath != null) ...[
            Image.asset(
              imagePath!,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            if (dateRange != null)
              Text(
                dateRange!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9999A3),
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(height: 18),
          ],
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All the Bills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(height: 18),
          _BillRow(label: 'Name', value: bill.name),
          _BillRow(label: 'Address', value: bill.address),
          _BillRow(label: 'Phone number', value: bill.phoneNumber),
          _BillRow(label: 'Code', value: bill.code),
          _BillRow(label: 'From', value: bill.fromDate),
          _BillRow(label: 'To', value: bill.toDate),
          const SizedBox(height: 12),
          _PriceRow(label: 'Internet fee', value: bill.fee),
          _PriceRow(label: 'Tax', value: bill.tax),
          const SizedBox(height: 10),
          _TotalRow(value: bill.total),
        ],
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  const _BillRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9999A3),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFEAEAF2)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9999A3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4338D1),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(18),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'TOTAL',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFFFF4D6D),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}