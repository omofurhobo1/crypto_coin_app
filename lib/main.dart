import 'dart:convert';
//import 'dart:js_util';

import 'package:crypto_coin_app/models/app_config.dart';
import 'package:crypto_coin_app/pages/home_page.dart';
import 'package:crypto_coin_app/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  httpServices();
  //await GetIt.instance.get<HttpService>().get("/coins/bitcoin");
  runApp(const MyApp());
}

void httpServices() {
  GetIt.instance.registerSingleton<HttpService>(HttpService());
}

Future<void> loadConfig() async {
  String _configContent =
      await rootBundle.loadString("assets/config/main.json");
  Map _configData = jsonDecode(_configContent);
  // print(_configData);
  GetIt.instance.registerSingleton<AppConfig>(AppConfig(
    COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
