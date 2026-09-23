import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// تخزين آمن لتوكن الجلسة (Sanctum Bearer)
class TokenStorage {
  static const _tokenKey = 'access_token';
  static const _expiresKey = 'token_expires_at';

  final FlutterSecureStorage _storage;

  const TokenStorage(this._storage);

  Future<void> saveToken(String token, {String? expiresAt}) async {
    await _storage.write(key: _tokenKey, value: token);
    if (expiresAt != null) {
      await _storage.write(key: _expiresKey, value: expiresAt);
    }
  }

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<bool> hasValidToken() async {
    final token = await readToken();
    if (token == null || token.isEmpty) return false;
    final expires = await _storage.read(key: _expiresKey);
    if (expires == null) return true;
    final date = DateTime.tryParse(expires);
    return date == null || date.isAfter(DateTime.now());
  }

  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expiresKey);
  }
}
