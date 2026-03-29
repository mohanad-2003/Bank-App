import 'package:banking_app/features/search/widgets/back_arrow_icon.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final VoidCallback? onBackTap;

  const SearchHeader({
    super.key,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackArrowIcon(onTap: onBackTap),
        const SizedBox(width: 14),
        const Expanded(
          child: Text(
            'Search',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xff2F2F2F),
              fontSize: 19.6,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}