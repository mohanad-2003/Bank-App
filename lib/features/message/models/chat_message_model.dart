class ChatMessageModel {
  final String text;
  final bool isMe;
  final String? dateLabel;

  const ChatMessageModel({
    required this.text,
    required this.isMe,
    this.dateLabel,
  });
}