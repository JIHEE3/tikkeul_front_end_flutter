import 'package:tikkeul/api/tikkeul_dio.dart';

Future<bool> isExistedId(String id) async {
  if (id.isEmpty) {
    throw Exception('Id is empty');
  }
  var dio = await tikkeulDio();
  var res = await dio.get('/users/exist/$id');

  return res.statusCode == 200 && res.data['isExist'];
}
