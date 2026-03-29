import 'package:banking_app/features/auth/screens/signin_screen.dart';
import 'package:banking_app/features/auth/screens/signup_screen.dart';
import 'package:banking_app/features/beneficiary-screen/widgets/beneficiary_confirm_screen.dart';
import 'package:banking_app/features/home/models/card_item_model.dart';
import 'package:banking_app/features/home/screens/account_and_card_screen.dart';
import 'package:banking_app/features/home/screens/card_detailes_screen.dart';
import 'package:banking_app/features/message/models/message_preview_model.dart';
import 'package:banking_app/features/message/screens/chat_details_screen.dart';
import 'package:banking_app/features/mobile-prepaid/screens/mobile_prepaid_confirm_screen.dart';
import 'package:banking_app/features/mobile-prepaid/screens/mobile_prepaid_screen.dart';
import 'package:banking_app/features/mobile-prepaid/screens/mobile_prepaid_success_screen.dart';
import 'package:banking_app/features/navigation/screens/main_navigation_screen.dart';
import 'package:banking_app/features/pay-bill/screens/internet_bill_details_screen.dart';
import 'package:banking_app/features/pay-bill/screens/internet_bill_form_screen.dart';
import 'package:banking_app/features/pay-bill/screens/internet_bill_success_screen.dart';
import 'package:banking_app/features/pay-bill/screens/pay_bill_screen.dart';
import 'package:banking_app/features/pay-bill/screens/payment_history_screen.dart';
import 'package:banking_app/features/beneficiary-screen/widgets/add_beneficiary_screen.dart';
import 'package:banking_app/features/save-online/screens/add_save_online_screen.dart';
import 'package:banking_app/features/beneficiary-screen/screens/beneficiary_screen.dart';
import 'package:banking_app/features/save-online/screens/choose_save_online_card_screen.dart';
import 'package:banking_app/features/save-online/screens/managenet_screen.dart';
import 'package:banking_app/features/save-online/screens/save_online_screen.dart';
import 'package:banking_app/features/save-online/screens/save_online_success_screen.dart';
import 'package:banking_app/features/search/screens/branch_search_screen.dart';
import 'package:banking_app/features/search/screens/exchange_rate_screen.dart';
import 'package:banking_app/features/search/screens/exchange_screen.dart';
import 'package:banking_app/features/search/screens/interest_rate_screen.dart';
import 'package:banking_app/features/search/screens/language_screen.dart';
import 'package:banking_app/features/settings/screens/app_information_screen.dart';
import 'package:banking_app/features/settings/screens/change_password_screen.dart';
import 'package:banking_app/features/transaction_report/screens/transaction_report_screen.dart';
import 'package:banking_app/features/transfer/screens/transfer_confirm_screen.dart';
import 'package:banking_app/features/transfer/screens/transfer_screen.dart';
import 'package:banking_app/features/transfer/screens/transfer_success_screen.dart';
import 'package:banking_app/features/auth/screens/forgot_password_screen.dart';
import 'package:banking_app/features/auth/screens/password_change_success_screen.dart';
import 'package:banking_app/features/auth/screens/verifyCodeScreen.dart';
import 'package:banking_app/features/withdraw/screens/withdraw_screen.dart';
import 'package:banking_app/features/withdraw/screens/withdraw_success_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/signin',
    routes: [
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => MainNavigationScreen(),
      ),
      GoRoute(
        path: '/verify-code',
        builder: (context, state) {
          final verificationId = state.extra as String;
          return VerifyCodeScreen(verificationId: verificationId);
        },
      ),
      GoRoute(
        path: '/branch-search',
        builder: (context, state) => const BranchSearchScreen(),
      ),

      GoRoute(
        path: '/app-information',
        builder: (context, state) => const AppInformationScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/password-success',
        builder: (context, state) => const PasswordChangedSuccessScreen(),
      ),
      GoRoute(
        path: '/interest-rate',
        builder: (context, state) => const InterestRateScreen(),
      ),
      GoRoute(
        path: '/exchange-rate',
        builder: (context, state) => const ExchangeRateScreen(),
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageScreen(),
      ),

      GoRoute(
        path: '/exchange',
        builder: (context, state) => const ExchangeScreen(),
      ),
      GoRoute(
        path: '/transfer',
        builder: (context, state) => const TransferScreen(),
      ),
      GoRoute(
        path: '/transfer-confirm',
        builder: (context, state) => const TransferConfirmScreen(),
      ),
      GoRoute(
        path: '/transfer-success',
        builder: (context, state) => const TransferSuccessScreen(),
      ),
      GoRoute(
        path: '/chat-detail',
        builder: (context, state) {
          final preview = state.extra as MessagePreviewModel;
          return ChatDetailScreen(preview: preview);
        },
      ),
      GoRoute(
        path: '/transaction-report',
        builder: (context, state) => const TransactionReportScreen(),
      ),
      GoRoute(
        path: '/account-card',
        name: 'account-card',
        builder: (context, state) => const AccountAndCardScreen(),
      ),
      GoRoute(
        path: '/card-detail',
        name: 'card-detail',
        builder: (context, state) {
          final card = state.extra as CardItemModel;
          return CardDetailScreen(card: card);
        },
      ),
      GoRoute(
        path: '/withdraw',
        name: 'withdraw',
        builder: (context, state) => const WithdrawScreen(),
      ),
      GoRoute(
        path: '/withdraw-success',
        name: 'withdraw-success',
        builder: (context, state) => const WithdrawSuccessScreen(),
      ),
      GoRoute(
        path: '/mobile-prepaid',
        name: 'mobile-prepaid',
        builder: (context, state) => const MobilePrepaidScreen(),
      ),
      GoRoute(
        path: '/mobile-prepaid-confirm',
        name: 'mobile-prepaid-confirm',
        builder: (context, state) => const MobilePrepaidConfirmScreen(),
      ),
      GoRoute(
        path: '/mobile-prepaid-success',
        name: 'mobile-prepaid-success',
        builder: (context, state) => const MobilePrepaidSuccessScreen(),
      ),
      GoRoute(
        path: '/pay-bill',
        name: 'pay-bill',
        builder: (context, state) => const PayBillScreen(),
      ),
      GoRoute(
        path: '/payment-history',
        name: 'payment-history',
        builder: (context, state) => const PaymentHistoryScreen(),
      ),
      GoRoute(
        path: '/internet-bill-form',
        name: 'internet-bill-form',
        builder: (context, state) => const InternetBillFormScreen(),
      ),
      GoRoute(
        path: '/internet-bill-details',
        name: 'internet-bill-details',
        builder: (context, state) => const InternetBillDetailsScreen(),
      ),
      GoRoute(
        path: '/internet-bill-success',
        name: 'internet-bill-success',
        builder: (context, state) => const InternetBillSuccessScreen(),
      ),
      GoRoute(
        path: '/save-online',
        name: 'save-online',
        builder: (context, state) => const SaveOnlineScreen(),
      ),
      GoRoute(
        path: '/save-online-add',
        name: 'save-online-add',
        builder: (context, state) => const AddSaveOnlineScreen(),
      ),
      GoRoute(
        path: '/choose-save-online-card',
        name: 'choose-save-online-card',
        builder: (context, state) => const ChooseSaveOnlineCardScreen(),
      ),
      GoRoute(
        path: '/save-online-success',
        name: 'save-online-success',
        builder: (context, state) => const SaveOnlineSuccessScreen(),
      ),
      GoRoute(
        path: '/management',
        builder: (context, state) => const ManagenetScreen(),
      ),
      GoRoute(
        path: '/beneficiary',
        builder: (context, state) => const BeneficiaryScreen(),
      ),
      GoRoute(
        path: '/add-beneficiary',
        builder: (context, state) => const AddBeneficiaryScreen(),
      ),
      GoRoute(
        path: '/beneficiary-confirm',
        builder: (context, state) => const BeneficiaryConfirmScreen(),
      ),
    ],
  );
});
