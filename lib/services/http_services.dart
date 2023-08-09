import 'package:crypto_coin_app/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio();
  AppConfig? _appConfig;
  String? _baseUrl;
  HttpService() {
    _appConfig = GetIt.instance<AppConfig>();
    _baseUrl = _appConfig!.COIN_API_BASE_URL;
  }
  Future<Response?> get(String _path) async {
    try {
      String _url = "$_baseUrl$_path";

      Response _response = await dio.get(_url);

      return _response;
    } catch (e) {
      print("Http Service: Unable to perform get request!");
      print(e);
    }
  }
}
