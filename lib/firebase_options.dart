// File generated for FlutterFire configuration.
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
    apiKey: 'AIzaSyDemoWebApiKeyForPracticeOnly12345',
    appId: '1:100000000000:web:abcdef1234567890abcdef',
    messagingSenderId: '100000000000',
    projectId: 'pmpl-pertemuan-4',
    authDomain: 'pmpl-pertemuan-4.firebaseapp.com',
    storageBucket: 'pmpl-pertemuan-4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoAndroidApiKeyForPractice1234',
    appId: '1:100000000000:android:abcdef1234567890abcdef',
    messagingSenderId: '100000000000',
    projectId: 'pmpl-pertemuan-4',
    storageBucket: 'pmpl-pertemuan-4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoIosApiKeyForPracticeOnly12345',
    appId: '1:100000000000:ios:abcdef1234567890abcdef',
    messagingSenderId: '100000000000',
    projectId: 'pmpl-pertemuan-4',
    storageBucket: 'pmpl-pertemuan-4.appspot.com',
    iosBundleId: 'com.example.pertemuan1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDemoMacosApiKeyForPracticeOnly123',
    appId: '1:100000000000:ios:abcdef1234567890abcdef',
    messagingSenderId: '100000000000',
    projectId: 'pmpl-pertemuan-4',
    storageBucket: 'pmpl-pertemuan-4.appspot.com',
    iosBundleId: 'com.example.pertemuan1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDemoWindowsApiKeyForPractice12345',
    appId: '1:100000000000:web:abcdef1234567890abcdef',
    messagingSenderId: '100000000000',
    projectId: 'pmpl-pertemuan-4',
    authDomain: 'pmpl-pertemuan-4.firebaseapp.com',
    storageBucket: 'pmpl-pertemuan-4.appspot.com',
  );
}
