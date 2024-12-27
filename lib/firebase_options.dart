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
    apiKey: 'AIzaSyD5nANd16lFAOKQO_lAPwxVmUjveVFvQq0',
    appId: '1:211816411616:web:135130d3dd388a4a74fb85',
    messagingSenderId: '211816411616',
    projectId: 'm-tech-internal-products',
    authDomain: 'm-tech-internal-products.firebaseapp.com',
    storageBucket: 'm-tech-internal-products.firebasestorage.app',
    measurementId: 'G-5NJHJN2P8C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAemSmVFtklp0_osRDIbOPklfWHPZD2Xkk',
    appId: '1:211816411616:android:d886dd634725d9ee74fb85',
    messagingSenderId: '211816411616',
    projectId: 'm-tech-internal-products',
    storageBucket: 'm-tech-internal-products.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiFcUa_R6ByfnNsRV37NGRDCfpH9OL7Bc',
    appId: '1:211816411616:ios:1c62862a5eaee52274fb85',
    messagingSenderId: '211816411616',
    projectId: 'm-tech-internal-products',
    storageBucket: 'm-tech-internal-products.firebasestorage.app',
    iosBundleId: 'com.example.dsoftFormApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAiFcUa_R6ByfnNsRV37NGRDCfpH9OL7Bc',
    appId: '1:211816411616:ios:1c62862a5eaee52274fb85',
    messagingSenderId: '211816411616',
    projectId: 'm-tech-internal-products',
    storageBucket: 'm-tech-internal-products.firebasestorage.app',
    iosBundleId: 'com.example.dsoftFormApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5nANd16lFAOKQO_lAPwxVmUjveVFvQq0',
    appId: '1:211816411616:web:20a4d8d3d259f06374fb85',
    messagingSenderId: '211816411616',
    projectId: 'm-tech-internal-products',
    authDomain: 'm-tech-internal-products.firebaseapp.com',
    storageBucket: 'm-tech-internal-products.firebasestorage.app',
    measurementId: 'G-QNBNZ5Z4QQ',
  );
}
