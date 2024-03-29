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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjroH9zIDGsd8zDsWVko68qnjcINr28fI',
    appId: '1:624992071157:web:332a4b59a9ef21ce4904bc',
    messagingSenderId: '624992071157',
    projectId: 'funesiaclone',
    authDomain: 'funesiaclone.firebaseapp.com',
    storageBucket: 'funesiaclone.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUbIZet7IRU8NLG4kGScqJ2ujK_Tu6I7Q',
    appId: '1:624992071157:android:7cd3cd055eb50a594904bc',
    messagingSenderId: '624992071157',
    projectId: 'funesiaclone',
    storageBucket: 'funesiaclone.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAmwcifQ1_5zjY4kmjCDD3wYnxL1gxp68',
    appId: '1:624992071157:ios:c61cb6006ee6dbbb4904bc',
    messagingSenderId: '624992071157',
    projectId: 'funesiaclone',
    storageBucket: 'funesiaclone.appspot.com',
    androidClientId: '624992071157-ic67dfsil8p2u8h2lepad6mtlnu8hn6v.apps.googleusercontent.com',
    iosClientId: '624992071157-rj2p4tu519d475613uog7tvncvb853q3.apps.googleusercontent.com',
    iosBundleId: 'com.hugo.funesiaClone',
  );
}
