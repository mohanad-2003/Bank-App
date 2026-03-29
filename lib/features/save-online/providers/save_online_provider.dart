import 'package:banking_app/features/save-online/models/save_online_duration_model.dart';
import 'package:banking_app/features/save-online/models/save_online_menu_item_model.dart';
import 'package:banking_app/features/home/models/card_item_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class SaveOnlineState {
  final List<SaveOnlineMenuItemModel> menuItems;
  final List<CardItemModel> cards;
  final List<SaveOnlineDurationModel> durations;
  final CardItemModel? selectedCard;
  final SaveOnlineDurationModel? selectedDuration;
  final String amount;
  final bool isSubmitting;

  const SaveOnlineState({
    required this.menuItems,
    required this.cards,
    required this.durations,
    required this.selectedCard,
    required this.selectedDuration,
    required this.amount,
    required this.isSubmitting,
  });

  factory SaveOnlineState.initial() {
    return const SaveOnlineState(
      menuItems: [
        SaveOnlineMenuItemModel(
          id: '1',
          title: 'Add',
          subtitle: 'Add new save online account',
          imagePath: 'assets/add.png',
          route: '/save-online-add',
        ),
        SaveOnlineMenuItemModel(
          id: '2',
          title: 'Management',
          subtitle: 'Manage your save online account',
          imagePath: 'assets/management.png',
          route: '/management',
        ),
      ],
      cards: [
        CardItemModel(
          holderName: 'John Smith',
          type: 'Amazon Platinium',
          number: '4756  ••••  ••••  9018',
          amount: '\$3.469.52',
          scheme: 'VISA',
          theme: BankCardTheme.blue,
          maskedCardNumber: '**** **** 9018',
          validFrom: '10/15',
          goodThru: '10/20',
          availableBalance: '\$10,000',
        ),
        CardItemModel(
          holderName: 'John Smith',
          type: 'Amazon Platinium',
          number: '4756  ••••  ••••  9018',
          amount: '\$3.469.52',
          scheme: '',
          theme: BankCardTheme.orange,
          maskedCardNumber: '**** **** 9018',
          validFrom: '11/16',
          goodThru: '11/21',
          availableBalance: '\$8,500',
        ),
      ],
      durations: [
        SaveOnlineDurationModel(id: '1', title: '3 months (Interest rate 4%)'),
        SaveOnlineDurationModel(
          id: '2',
          title: '6 months (Interest rate 4.5%)',
        ),
        SaveOnlineDurationModel(id: '3', title: '12 months (Interest rate 5%)'),
        SaveOnlineDurationModel(
          id: '4',
          title: '16 months (Interest rate 5.5%)',
        ),
        SaveOnlineDurationModel(id: '5', title: '24 months (Interest rate 6%)'),
      ],
      selectedCard: null,
      selectedDuration: null,
      amount: '',
      isSubmitting: false,
    );
  }

  SaveOnlineState copyWith({
    List<SaveOnlineMenuItemModel>? menuItems,
    List<CardItemModel>? cards,
    List<SaveOnlineDurationModel>? durations,
    CardItemModel? selectedCard,
    bool clearSelectedCard = false,
    SaveOnlineDurationModel? selectedDuration,
    bool clearSelectedDuration = false,
    String? amount,
    bool? isSubmitting,
  }) {
    return SaveOnlineState(
      menuItems: menuItems ?? this.menuItems,
      cards: cards ?? this.cards,
      durations: durations ?? this.durations,
      selectedCard: clearSelectedCard
          ? null
          : (selectedCard ?? this.selectedCard),
      selectedDuration: clearSelectedDuration
          ? null
          : (selectedDuration ?? this.selectedDuration),
      amount: amount ?? this.amount,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  bool get isValid =>
      selectedCard != null &&
      selectedDuration != null &&
      amount.trim().isNotEmpty;
}

class SaveOnlineNotifier extends StateNotifier<SaveOnlineState> {
  SaveOnlineNotifier() : super(SaveOnlineState.initial());

  void selectCard(CardItemModel card) {
    state = state.copyWith(selectedCard: card);
  }

  void selectDuration(SaveOnlineDurationModel duration) {
    state = state.copyWith(selectedDuration: duration);
  }

  void updateAmount(String value) {
    state = state.copyWith(amount: value);
  }

  Future<bool> submit() async {
    if (!state.isValid) return false;
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(milliseconds: 900));
    state = state.copyWith(isSubmitting: false);
    return true;
  }

  void reset() {
    state = SaveOnlineState.initial();
  }
}

final saveOnlineProvider =
    StateNotifierProvider<SaveOnlineNotifier, SaveOnlineState>(
      (ref) => SaveOnlineNotifier(),
    );
