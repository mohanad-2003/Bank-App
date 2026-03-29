import 'package:flutter/material.dart';

class BeneficiaryAvatarItem extends StatelessWidget {
  final String name;
  final String? imagePath;
  final bool isSelected;
  final bool isAddButton;
  final VoidCallback onTap;

  const BeneficiaryAvatarItem({
    super.key,
    required this.name,
    this.imagePath,
    required this.isSelected,
    required this.isAddButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarBorder = isSelected
        ? const Color(0xff4A3FE2)
        : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 66,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff4A3FE2) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: avatarBorder, width: 2),
                color: isAddButton ? const Color(0xffF2EFFA) : null,
              ),
              child: isAddButton
                  ? const Icon(
                      Icons.add,
                      color: Color(0xffD7D3E8),
                    )
                  : ClipOval(
                      child: Image.asset(
                        imagePath ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person);
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Colors.white : const Color(0xff444444),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}