import 'package:flutter_secure_storage/flutter_secure_storage.dart';

addAccessToken(String accessToken) async {
  const storage = FlutterSecureStorage();

  await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
}

getAccessToken() async {
  const storage = FlutterSecureStorage();

  return await storage.read(key: 'ACCESS_TOKEN');
}

addRefreshToken(String refreshToken) async {
  const storage = FlutterSecureStorage();

  await storage.write(key: 'REFRESH_TOKEN', value: refreshToken);
}

getRefreshToken() async {
  const storage = FlutterSecureStorage();

  return await storage.read(key: 'REFRESH_TOKEN');
}
