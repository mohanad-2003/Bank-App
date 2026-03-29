import 'package:banking_app/features/message/models/message_preview_model.dart';
import 'package:banking_app/features/message/providers/message_provider.dart';
import 'package:banking_app/features/message/widgets/chat_bubble.dart';
import 'package:banking_app/features/message/widgets/chat_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final MessagePreviewModel preview;

  const ChatDetailScreen({
    super.key,
    required this.preview,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  late final TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider(widget.preview.id));

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth * 0.06;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (context.canPop()) context.pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.preview.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff2D2D2D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '8/10/2018',
                  style: TextStyle(
                    color: Color(0xffB0B0B0),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final item = messages[index];

                      return Column(
                        children: [
                          if (item.dateLabel != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item.dateLabel!,
                                style: const TextStyle(
                                  color: Color(0xffB0B0B0),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ChatBubble(
                            text: item.text,
                            isMe: item.isMe,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    10,
                    horizontalPadding,
                    16,
                  ),
                  child: ChatInputBar(
                    controller: messageController,
                    onChanged: (value) {
                      ref.read(currentInputProvider.notifier).state = value;
                      setState(() {});
                    },
                    onSend: () {
                      messageController.clear();
                      ref.read(currentInputProvider.notifier).state = '';
                      setState(() {});
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}