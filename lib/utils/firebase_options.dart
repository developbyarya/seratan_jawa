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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBcxPJuj3qT7-MiTd_RA-EaLZwFYxgH0sY',
    appId: '1:197040451030:web:1b40bc87a0de5333a64877',
    messagingSenderId: '197040451030',
    projectId: 'seratanjawi',
    authDomain: 'seratanjawi.firebaseapp.com',
    storageBucket: 'seratanjawi.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXHicPyX6Xfsl09bIcNz-JNuWs-NztcKA',
    appId: '1:197040451030:android:20683f20f6a8f1b3a64877',
    messagingSenderId: '197040451030',
    projectId: 'seratanjawi',
    storageBucket: 'seratanjawi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCt9h5PhTXJWLzQC-QADs_2uxmD1Ouq71Y',
    appId: '1:197040451030:ios:f251bf1dd6e8d4cfa64877',
    messagingSenderId: '197040451030',
    projectId: 'seratanjawi',
    storageBucket: 'seratanjawi.appspot.com',
    iosClientId: '197040451030-s32o78233s9qvg79jb0k3ni527pgggb2.apps.googleusercontent.com',
    iosBundleId: 'com.example.v1',
  );
}