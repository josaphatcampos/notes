import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class SecureStorageService {
  static const _secureKeyName = 'hive_encryption_key';
  static const _storage = FlutterSecureStorage();

  static Future<List<int>> getEncryptionKey() async {
    final encodedKey = await _storage.read(key: _secureKeyName);
    if (encodedKey != null) {
      return base64Url.decode(encodedKey);
    }

    final key = Hive.generateSecureKey();
    await _storage.write(key: _secureKeyName, value: base64UrlEncode(key));
    return key;
  }
}
