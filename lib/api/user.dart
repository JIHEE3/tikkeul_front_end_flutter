import 'package:dio/dio.dart';
import 'package:tikkeul/api/tikkeul_dio.dart';

Future<bool> isExistedId(String id) async {
  if (id.isEmpty) {
    throw Exception('Id is empty');
  }
  var dio = await tikkeulDio();
  var res = await dio.get('/users/exist/$id');

  return res.statusCode == 200 && res.data['isExist'];
}

signUp(FormData formData) async {
  var dio = await tikkeulDio();
  dio.options.contentType = 'multipart/form-data';

  return await dio.post('/users/signup', data: formData);
}

signIn(String id, String password) async {
  var dio = await tikkeulDio();

  return await dio
      .post('/users/signin', data: {'id': id, 'password': password});
}
