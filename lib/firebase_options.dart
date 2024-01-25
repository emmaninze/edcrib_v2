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
    apiKey: 'AIzaSyAINmwlzYGYrRGnMivNXeU0vpt_1paO36A',
    appId: '1:551476938565:web:1fd5d621263e373d46e02c',
    messagingSenderId: '551476938565',
    projectId: 'edcrib',
    authDomain: 'edcrib.firebaseapp.com',
    storageBucket: 'edcrib.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8G0n1jtMJxPq_7UIdeEm06aSdUJR4OXM',
    appId: '1:551476938565:android:dd82ffefcd39daa746e02c',
    messagingSenderId: '551476938565',
    projectId: 'edcrib',
    storageBucket: 'edcrib.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdTWLWnpSiAItGftuZKmGUbgIkglCsHtI',
    appId: '1:551476938565:ios:ab1fed960ef6520046e02c',
    messagingSenderId: '551476938565',
    projectId: 'edcrib',
    storageBucket: 'edcrib.appspot.com',
    iosClientId:
        '551476938565-ask9i5slam7nuqinseaiibr217187o15.apps.googleusercontent.com',
    iosBundleId: 'com.edcrib.edcrib',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdTWLWnpSiAItGftuZKmGUbgIkglCsHtI',
    appId: '1:551476938565:ios:ab1fed960ef6520046e02c',
    messagingSenderId: '551476938565',
    projectId: 'edcrib',
    storageBucket: 'edcrib.appspot.com',
    iosClientId:
        '551476938565-ask9i5slam7nuqinseaiibr217187o15.apps.googleusercontent.com',
    iosBundleId: 'com.edcrib.edcrib',
  );
}
