// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDBD5qWWqZZ2fgNdGfAN3sFxudV9Uf2w40',
    appId: '1:179028552271:web:88a97e6fa640cb3c93983a',
    messagingSenderId: '179028552271',
    projectId: 'social-app-a667b',
    authDomain: 'social-app-a667b.firebaseapp.com',
    storageBucket: 'social-app-a667b.appspot.com',
    measurementId: 'G-QE0C59V3BL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPpB9GcYFa7jsmtUJ8kWeyuRuhrqoLVgQ',
    appId: '1:179028552271:android:b1321faa90542df493983a',
    messagingSenderId: '179028552271',
    projectId: 'social-app-a667b',
    storageBucket: 'social-app-a667b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAf2G0bOPWW8HyeGdN1jJ1xUdhevlpTpXA',
    appId: '1:179028552271:ios:5a3b6d024bb0e15893983a',
    messagingSenderId: '179028552271',
    projectId: 'social-app-a667b',
    storageBucket: 'social-app-a667b.appspot.com',
    iosClientId: '179028552271-bvd3llevgkc6rk94r4am2igpeu5bk81r.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAf2G0bOPWW8HyeGdN1jJ1xUdhevlpTpXA',
    appId: '1:179028552271:ios:0b35c99649c007ad93983a',
    messagingSenderId: '179028552271',
    projectId: 'social-app-a667b',
    storageBucket: 'social-app-a667b.appspot.com',
    iosClientId: '179028552271-u9f1uomus7sdj9srvv9fn751dh4d6j65.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp.RunnerTests',
  );
}
