import 'package:banking_app/features/message/models/chat_message_model.dart';
import 'package:banking_app/features/message/models/message_preview_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final messagesPreviewProvider = Provider<List<MessagePreviewModel>>((ref) {
  return  [
    MessagePreviewModel(
      id: 'boa',
      title: 'Bank of America',
      subtitle: 'Bank of America : 254846 is the authorization code...',
      dateText: 'Today',
      iconType: 'bank',
      isToday: true,
    ),
    MessagePreviewModel(
      id: 'account',
      title: 'Account',
      subtitle: 'Your account is limited. Please follow the steps...',
      dateText: '12/10',
      iconType: 'account',
    ),
    MessagePreviewModel(
      id: 'alert',
      title: 'Alert',
      subtitle: 'Your statement is ready for you to review.',
      dateText: '10/10',
      iconType: 'alert',
    ),
    MessagePreviewModel(
      id: 'paypal',
      title: 'Paypal',
      subtitle: 'Your account has been locked. Please verify...',
      dateText: '10/11',
      iconType: 'paypal',
    ),
    MessagePreviewModel(
      id: 'withdraw',
      title: 'Withdraw',
      subtitle: 'Dear customer, 29847156 is your code...',
      dateText: '10/12',
      iconType: 'withdraw',
    ),
  ];
});

final chatMessagesProvider =
    Provider.family<List<ChatMessageModel>, String>((ref, chatId) {
  if (chatId == 'boa') {
    return const [
      ChatMessageModel(
        text:
            'Did you attempt transaction on debit card ending in 0000 at Mechani in NJ for \$1,200?\nReply YES or NO',
        isMe: false,
      ),
      ChatMessageModel(
        text: 'Yes',
        isMe: true,
        dateLabel: '8/10/2018',
      ),
      ChatMessageModel(
        text:
            'Bank of America : 254846 is your authorization code which expires in 10 minutes. If you didn\'t request the code. Call : 18009888 for assistance',
        isMe: false,
      ),
      ChatMessageModel(
        text: 'Thanks!',
        isMe: true,
      ),
    ];
  }

  return const [
    ChatMessageModel(
      text: 'Hello',
      isMe: false,
    ),
  ];
});

final currentInputProvider = StateProvider<String>((ref) => '');