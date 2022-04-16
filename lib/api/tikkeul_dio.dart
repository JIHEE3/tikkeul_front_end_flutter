import 'package:dio/dio.dart';
import 'package:tikkeul/constants/enums.dart';
import 'package:tikkeul/utils/tikkeul_snack_bar.dart';

Future<Dio> tikkeulDio() async {
  var dio = Dio();
  dio.options.baseUrl = 'http://192.168.0.20:8090';

  dio.interceptors.add(InterceptorsWrapper(
    // onRequest: (options, handler) {},
    onError: (error, handler) {
      if (error.response == null) {
        var tsb = TikkeulSnackBar(
          message: "네트워크 에러 입니다. 관리자에게 문의하세요.",
          type: SnackBarType.error,
        );

        tsb.showSnackBar();
      }
    },
  ));

  return dio;
}
