
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
    apiKey: 'AIzaSyDPLrf3eOYf-8x3Ux_3nXdo9YTL3obmbuc',
    appId: '1:1074390991354:web:e667ce90c229c3447e2443',
    messagingSenderId: '1074390991354',
    projectId: 'authenticator-f8ee8',
    authDomain: 'authenticator-f8ee8.firebaseapp.com',
    storageBucket: 'authenticator-f8ee8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxs2YeLTfkhTI2uNWGq1_BfT-mF3u6Egs',
    appId: '1:1074390991354:ios:b8e53a029ed1c6607e2443',
    messagingSenderId: '1074390991354',
    projectId: 'authenticator-f8ee8',
    storageBucket: 'authenticator-f8ee8.firebasestorage.app',
    iosBundleId: 'com.example.authenticator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxs2YeLTfkhTI2uNWGq1_BfT-mF3u6Egs',
    appId: '1:1074390991354:ios:b8e53a029ed1c6607e2443',
    messagingSenderId: '1074390991354',
    projectId: 'authenticator-f8ee8',
    storageBucket: 'authenticator-f8ee8.firebasestorage.app',
    iosBundleId: 'com.example.authenticator',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDPLrf3eOYf-8x3Ux_3nXdo9YTL3obmbuc',
    appId: '1:1074390991354:web:b7727fdff9ac776a7e2443',
    messagingSenderId: '1074390991354',
    projectId: 'authenticator-f8ee8',
    authDomain: 'authenticator-f8ee8.firebaseapp.com',
    storageBucket: 'authenticator-f8ee8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChUwx5LjdR6jIPRJ9yHjxZPHT-s9EFtVA',
    appId: '1:1074390991354:android:8af572140fc331117e2443',
    messagingSenderId: '1074390991354',
    projectId: 'authenticator-f8ee8',
    storageBucket: 'authenticator-f8ee8.firebasestorage.app',
  );
}
