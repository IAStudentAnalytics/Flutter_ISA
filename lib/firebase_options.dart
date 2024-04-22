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
    apiKey: 'AIzaSyBBHyeAKBD6FaaGNIpmd44L_JUM2plEMFw',
    appId: '1:543868268642:web:e7f9ee9a96f6316d71613b',
    messagingSenderId: '543868268642',
    projectId: 'eduswift-12eeb',
    authDomain: 'eduswift-12eeb.firebaseapp.com',
    storageBucket: 'eduswift-12eeb.appspot.com',
    measurementId: 'G-PRY0KBSPCW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYxzxos704C56V8czZj54xMopFvCWrQq8',
    appId: '1:543868268642:android:038712c11f7f3c5171613b',
    messagingSenderId: '543868268642',
    projectId: 'eduswift-12eeb',
    storageBucket: 'eduswift-12eeb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrfZvbfFM8KmVjhoWbUXH3_kbLU2gSNC8',
    appId: '1:543868268642:ios:ef7b7ef5b4b86ad371613b',
    messagingSenderId: '543868268642',
    projectId: 'eduswift-12eeb',
    storageBucket: 'eduswift-12eeb.appspot.com',
    iosBundleId: 'com.example.performance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrfZvbfFM8KmVjhoWbUXH3_kbLU2gSNC8',
    appId: '1:543868268642:ios:ef7b7ef5b4b86ad371613b',
    messagingSenderId: '543868268642',
    projectId: 'eduswift-12eeb',
    storageBucket: 'eduswift-12eeb.appspot.com',
    iosBundleId: 'com.example.performance',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBBHyeAKBD6FaaGNIpmd44L_JUM2plEMFw',
    appId: '1:543868268642:web:b768a02e8938ef4171613b',
    messagingSenderId: '543868268642',
    projectId: 'eduswift-12eeb',
    authDomain: 'eduswift-12eeb.firebaseapp.com',
    storageBucket: 'eduswift-12eeb.appspot.com',
    measurementId: 'G-DCJ6MNM6JW',
  );
}
