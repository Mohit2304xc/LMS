import 'package:dummy1/Screen/LoginScreen.dart';
import 'package:dummy1/Screen/Onboarding.dart';
import 'package:dummy1/Screen/VerifyEmailAddress.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'package:dummy1/Widgets/Services/LocalStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Exceptions/firebase_auth_exceptions.dart';
import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/format_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';
import 'UserRepository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final User? user = _auth.currentUser;
    await TLocalStorage.init('user_storage'); // Initialize LocalStorage

    final deviceStorage = TLocalStorage.instance();
    if (user != null) {
      if (user.emailVerified) {
        await TLocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else if (user.providerData
          .any((provider) => provider.providerId == 'google.com')) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmail(email: _auth.currentUser?.email));
      }
    } else {
      // Local storage
      final isFirstTime = deviceStorage.readData<bool>('IsFirstTime');
      if (isFirstTime == null || isFirstTime) {
        Get.offAll(() => const OnboardingScreen());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    }
  }

  /// Email and Password Sign In
  /// Email Authentication login user
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again after sometime';
    }
  }

  /// Email Authentication register user
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again after sometime';
    }
  }

  /// Email Authentication
  /// Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again after sometime';
    }
  }

  /// Re Authenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }

  ///Delete User
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }

  ///Forgot Password
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again later';
    }
  }

  ///logout function
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong.Please try again after sometime';
    }
  }

  ///Google Sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong:$e');
      return null;
    }
  }
}
