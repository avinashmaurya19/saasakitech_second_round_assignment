// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAHn6X0wTAmLz1o82tRnRkbR08Pyb6eOtM',
    appId: '1:795300546102:web:904dd9c141bb23a5b8fa97',
    messagingSenderId: '795300546102',
    projectId: 'email-password-login-signup',
    authDomain: 'email-password-login-signup.firebaseapp.com',
    storageBucket: 'email-password-login-signup.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9pzPDWZRfI8GTjLZiC6Q-9-o8pDVspvo',
    appId: '1:795300546102:android:4d6725dda283d55bb8fa97',
    messagingSenderId: '795300546102',
    projectId: 'email-password-login-signup',
    storageBucket: 'email-password-login-signup.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0P2WRiYzb0sseOEufYRtO4RE6Xh0FYV0',
    appId: '1:795300546102:ios:20cd6136ced01a8fb8fa97',
    messagingSenderId: '795300546102',
    projectId: 'email-password-login-signup',
    storageBucket: 'email-password-login-signup.appspot.com',
    iosBundleId: 'com.example.saasakitechSecondRoundAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0P2WRiYzb0sseOEufYRtO4RE6Xh0FYV0',
    appId: '1:795300546102:ios:20cd6136ced01a8fb8fa97',
    messagingSenderId: '795300546102',
    projectId: 'email-password-login-signup',
    storageBucket: 'email-password-login-signup.appspot.com',
    iosBundleId: 'com.example.saasakitechSecondRoundAssignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHn6X0wTAmLz1o82tRnRkbR08Pyb6eOtM',
    appId: '1:795300546102:web:98617962d9c12f80b8fa97',
    messagingSenderId: '795300546102',
    projectId: 'email-password-login-signup',
    authDomain: 'email-password-login-signup.firebaseapp.com',
    storageBucket: 'email-password-login-signup.appspot.com',
  );
}
