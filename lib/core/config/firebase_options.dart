import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDoHTpnhC_T-ZXJd_958dgremtuVfS4I5c',
    appId: '1:866880662959:web:784c529b6977ce3168535a',
    messagingSenderId: '866880662959',
    projectId: 'cocus-notes-app',
    authDomain: 'cocus-notes-app.firebaseapp.com',
    storageBucket: 'cocus-notes-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAg6nbAVDIKUDlOCagDsJwGg-cdgAYxyCQ',
    appId: '1:866880662959:android:89863c7715d6d4ed68535a',
    messagingSenderId: '866880662959',
    projectId: 'cocus-notes-app',
    storageBucket: 'cocus-notes-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXQIvRfjZzBZL06WYu_9cEW65YYNb_L9g',
    appId: '1:866880662959:ios:727fc52e56cbec4068535a',
    messagingSenderId: '866880662959',
    projectId: 'cocus-notes-app',
    storageBucket: 'cocus-notes-app.firebasestorage.app',
    iosBundleId: 'dev.jocampos.cocus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXQIvRfjZzBZL06WYu_9cEW65YYNb_L9g',
    appId: '1:866880662959:ios:727fc52e56cbec4068535a',
    messagingSenderId: '866880662959',
    projectId: 'cocus-notes-app',
    storageBucket: 'cocus-notes-app.firebasestorage.app',
    iosBundleId: 'dev.jocampos.cocus',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDoHTpnhC_T-ZXJd_958dgremtuVfS4I5c',
    appId: '1:866880662959:web:7885226dfdc6390968535a',
    messagingSenderId: '866880662959',
    projectId: 'cocus-notes-app',
    authDomain: 'cocus-notes-app.firebaseapp.com',
    storageBucket: 'cocus-notes-app.firebasestorage.app',
  );
}
