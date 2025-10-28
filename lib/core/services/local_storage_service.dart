import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const _secureKeyName = 'hive_encryption_key';
  static const _storage = FlutterSecureStorage();

  static Future<void> init() async {
    await Hive.initFlutter();
    final encryptionKey = await _getEncryptionKey();
    await Hive.openBox(
      'notes',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  static Box get box => Hive.box('notes');

  static Future<List<int>> _getEncryptionKey() async {
    final existingKey = await _storage.read(key: _secureKeyName);
    if (existingKey != null) {
      return base64Url.decode(existingKey);
    }

    final newKey = Hive.generateSecureKey();
    await _storage.write(
      key: _secureKeyName,
      value: base64UrlEncode(newKey),
    );
    return newKey;
  }
}
