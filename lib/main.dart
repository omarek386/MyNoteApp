import 'dart:convert';

import 'package:asfasfasf/models/app_config.dart';
import 'package:asfasfasf/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'pages/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appConfig();
  registerHttpService();
  GetIt.instance.get<HttpService>().get('/coins/bitcoin');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

Future appConfig() async {
  String _config_constant =
      await rootBundle.loadString('assets/configs/main.json');
  Map _base_url = jsonDecode(_config_constant);
  print(_base_url);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(
      COIN_BASE_URL_API: _base_url['COIN_BASE_URL_API'],
    ),
  );
}

void registerHttpService() {
  GetIt.instance.registerSingleton<HttpService>(
    HttpService(),
  );
}
