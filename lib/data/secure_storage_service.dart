import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Lưu trữ giá trị
  Future<void> savetoken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  // Truy xuất giá trị
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Xóa giá trị
  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}
