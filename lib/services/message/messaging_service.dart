import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagingService {
  const MessagingService();

  bool isPhoneValid(String phone) {
    return phone.trim().isNotEmpty;
  }

  Future<bool> sendBookingMessage(String phoneNumber) async {
    try {
      final messageBody = buildMessageBody();
      return await sendSMS(
        phoneNumber: phoneNumber,
        messageBody: messageBody,
      );
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }

  String buildMessageBody({
    String template = 'Tere, mina olen {name}{email} ja ma soovin teatada, et ',
  }) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim();
    final email = user?.email?.trim();
    final displayName = (name != null && name.isNotEmpty) ? name : 'klient';
    final emailPart = (email != null && email.isNotEmpty) ? ' ($email)' : '';

    return template
        .replaceFirst('{name}', displayName)
        .replaceFirst('{email}', emailPart);
  }

  Future<bool> sendSMS({
    required String phoneNumber,
    required String messageBody,
  }) async {
    final phone = phoneNumber.trim();
    if (phone.isEmpty) {
      return false;
    }

    final encodedBody = Uri.encodeComponent(messageBody);
    final smsUriString = 'sms:$phone?body=$encodedBody';
    final smsUri = Uri.parse(smsUriString);

    try {
      final canLaunch = await launchUrl(smsUri);

      if (!canLaunch) {
        print('Cannot launch SMS URI: $smsUri');
        return false;
      }

      final launched = await launchUrl(
        smsUri,
        mode: LaunchMode.externalApplication,
      );

      print('SMS launch result: $launched');
      return launched;
    } catch (e) {
      print('Error launching SMS app: $e');
      return false;
    }
  }
}