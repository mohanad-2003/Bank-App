import 'package:banking_app/features/search/models/search_item_model.dart';
import 'package:banking_app/features/search/widgets/search_card_content.dart';
import 'package:flutter/material.dart';

class SearchOptionCard extends StatelessWidget {
  final SearchItemModel item;
  final VoidCallback? onTap;

  const SearchOptionCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth * 0.30;
        final cardHeight = constraints.maxWidth < 360 ? 108.0 : 116.0;

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            height: cardHeight,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.025),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SearchCardTextContent(
                    title: item.title,
                    subtitle: item.subtitle,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      item.imagePath,
                      width: imageWidth,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: imageWidth * 0.88,
                          height: imageWidth * 0.88,
                          decoration: BoxDecoration(
                            color: const Color(0xffF1F3FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.image_outlined,
                            color: Color(0xff3B2CCB),
                            size: 28,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}