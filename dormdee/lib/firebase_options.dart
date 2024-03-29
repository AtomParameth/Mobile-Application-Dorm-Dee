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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCH_gH2cm6ElTvp-ANM387tGQaITlQznvU',
    appId: '1:529712825170:android:61197ddef721f52c54f08b',
    messagingSenderId: '529712825170',
    projectId: 'dormdee-9f6ed',
    storageBucket: 'dormdee-9f6ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqvBd8nj9xtmfevqL_EOO8GCHxJcFTjWI',
    appId: '1:529712825170:ios:fa04ee8ebef1f8e154f08b',
    messagingSenderId: '529712825170',
    projectId: 'dormdee-9f6ed',
    storageBucket: 'dormdee-9f6ed.appspot.com',
    androidClientId: '529712825170-got5a49crnqh337jplur8uts4ieu0q03.apps.googleusercontent.com',
    iosClientId: '529712825170-9ora2lesp1ob77bbtg7oa02vem20eo46.apps.googleusercontent.com',
    iosBundleId: 'com.example.dormdee',
  );
}
