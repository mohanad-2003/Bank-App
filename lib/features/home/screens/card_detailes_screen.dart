import 'package:banking_app/features/home/widgets/card_detailes_row.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/features/home/models/card_item_model.dart';
import 'package:banking_app/features/home/widgets/screen_header.dart';

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({super.key, required this.card});

  final CardItemModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;
            final contentMaxWidth = constraints.maxWidth > 500
                ? 460.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ScreenHeader(
                        title: 'Card',
                        onBackTap: () => Navigator.of(context).maybePop(),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          children: [
                            CardDetailRow(
                              title: 'Name',
                              value: card.holderName,
                              isHighlighted: true,
                            ),
                            CardDetailRow(
                              title: 'Card number',
                              value: card.maskedCardNumber,
                              isHighlighted: true,
                            ),
                            CardDetailRow(
                              title: 'Valid from',
                              value: card.validFrom,
                              isHighlighted: true,
                            ),
                            CardDetailRow(
                              title: 'Good thru',
                              value: card.goodThru,
                              isHighlighted: true,
                            ),
                            CardDetailRow(
                              title: 'Available balance',
                              value: card.availableBalance,
                              isHighlighted: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Delete card',
                            style: TextStyle(
                              color: Color(0xFFFF4D5E),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
