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
    apiKey: 'AIzaSyCMjAKj1qtcDWDj3PAya_g4A-TCVGtsxJc',
    appId: '1:953790512738:web:c00b95a87518d46fdbdb3b',
    messagingSenderId: '953790512738',
    projectId: 'pmpl-firebase-authentication',
    authDomain: 'pmpl-firebase-authentication.firebaseapp.com',
    storageBucket: 'pmpl-firebase-authentication.firebasestorage.app',
    measurementId: 'G-24CLCPSQJY',
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDL-KIulAqVmtSRnen8zQ3urIcUDar58Sg',
    appId: '1:953790512738:android:3439fe33fe2dd666dbdb3b',
    messagingSenderId: '953790512738',
    projectId: 'pmpl-firebase-authentication',
    storageBucket: 'pmpl-firebase-authentication.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCElVPbM15VqByS3AqXgBhjoRgGjTdBof8',
    appId: '1:953790512738:ios:daaf9f4dc94e01dcdbdb3b',
    messagingSenderId: '953790512738',
    projectId: 'pmpl-firebase-authentication',
    storageBucket: 'pmpl-firebase-authentication.firebasestorage.app',
    iosBundleId: 'com.example.pertemuan1',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCElVPbM15VqByS3AqXgBhjoRgGjTdBof8',
    appId: '1:953790512738:ios:daaf9f4dc94e01dcdbdb3b',
    messagingSenderId: '953790512738',
    projectId: 'pmpl-firebase-authentication',
    storageBucket: 'pmpl-firebase-authentication.firebasestorage.app',
    iosBundleId: 'com.example.pertemuan1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCMjAKj1qtcDWDj3PAya_g4A-TCVGtsxJc',
    appId: '1:953790512738:web:c28e7152a080712cdbdb3b',
    messagingSenderId: '953790512738',
    projectId: 'pmpl-firebase-authentication',
    authDomain: 'pmpl-firebase-authentication.firebaseapp.com',
    storageBucket: 'pmpl-firebase-authentication.firebasestorage.app',
    measurementId: 'G-NK2JLH29BL',
  );
}
