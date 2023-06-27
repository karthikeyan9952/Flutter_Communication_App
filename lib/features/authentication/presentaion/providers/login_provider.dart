import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_communication_app/features/authentication/models/user.dart'
    as model;
import 'package:realtime_communication_app/utilities/keys.dart';
import 'package:realtime_communication_app/utilities/providers.dart';

class LoginProvider extends ChangeNotifier {
  String _mobile = "";
  String get mobile => _mobile;
  set mobile(String newMobile) {
    _mobile = newMobile;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // User? _currentUser;
  // User? get currentUser => _currentUser;
  // set currentUser(User? user) {
  //   _currentUser = user;
  //   notifyListeners();
  // }

  Future login() async {
    isLoading = true;
    logger.e(mobile);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 $mobile',
      verificationCompleted: (PhoneAuthCredential credential) async {
        logger.i("Success");
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          logger.e('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    isLoading = false;
  }

  Future<GoogleSignInAccount> signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await auth.signInWithCredential(credential);
    var user = authResult.user;
    assert(!user!.isAnonymous);
    return googleSignInAccount;
  }

  Future googleSignout() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      logger.i("Success!");
    } catch (e) {
      logger.e(e);
    }
  }
}
