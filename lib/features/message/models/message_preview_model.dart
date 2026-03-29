class MessagePreviewModel {
  final String id;
  final String title;
  final String subtitle;
  final String dateText;
  final String iconType;
  final String? avatarAsset;
  final bool isToday;

  const MessagePreviewModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dateText,
    required this.iconType,
    this.avatarAsset,
    this.isToday = false,
  });
}