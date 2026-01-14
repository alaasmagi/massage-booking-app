import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MicrosoftAuthService {
  static Future<UserCredential> signInWithMicrosoft() async {
    final provider = OAuthProvider("microsoft.com");
    provider.setScopes(['openid', 'profile', 'email']);
    provider.setCustomParameters({'tenant': 'common'});

    return kIsWeb
        ? FirebaseAuth.instance.signInWithPopup(provider)
        : FirebaseAuth.instance.signInWithProvider(provider);
  }
}