// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/app_config.dart';

class HttpService {
  final Dio dio = Dio();
  AppConfig? _appConfig;
  String? _base_url;
  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.COIN_BASE_URL_API;
  }

  get(String _path) async {
    try {
      String _url = "$_base_url$_path";
      Response _response = await dio.get(_url);
      print(_response);
      return _response;
    } catch (e) {
      print('HttpError: $e');
      return null;
    }
  }
}
