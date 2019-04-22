import 'dart:core';
import 'package:http/http.dart' as http;

enum NetworkEnvironment {
  dev,
  prod,
  test,
}

class NetworkConfig {
  static String apiToken;
  static NetworkConfig get instance => _getInstance();
  static NetworkConfig _instance;
  static NetworkConfig _getInstance() {
    if (_instance == null) {
      _instance = new NetworkConfig._internal();
    }
    return _instance;
  }

  NetworkConfig._internal() {
    // 初始化
  }

  NetworkEnvironment environment = NetworkEnvironment.dev;

  String getBaseUrl(){
    switch (environment){
      case NetworkEnvironment.dev:
        return "https://development.api.ctirobot.com";
      case NetworkEnvironment.prod:
        return "https://api.ctirobot.com";
      case NetworkEnvironment.test:
        return "https://staging.api.ctirobot.com";
      default:
        break;
    }
    return "";
  }

  Map<String, String> getHttpHeader() {
    switch (environment){
      case NetworkEnvironment.dev:
        return {
          "Authorization":"Bearer $apiToken",
          "Content-Type":"application/json"
        };
      case NetworkEnvironment.prod:
        return {
          "Authorization":"Bearer $apiToken",
          "Content-Type":"application/json"
        };
      case NetworkEnvironment.test:
        return {
          "Authorization":"Bearer $apiToken",
          "Content-Type":"application/json"
        };
      default:
        return {
          "Authorization":"Bearer $apiToken",
          "Content-Type":"application/json"
        };
    }
  }
}

class Http {

  factory Http() =>_getInstance();
  static Http get instance => _getInstance();
  static Http _instance;

  Http._internal() {
    // 初始化
  }

  static Http _getInstance() {
    if (_instance == null) {
      _instance = new Http._internal();
    }
    return _instance;
  }

  Future<http.Response> post(url, { body }) async {
    String _url = '${NetworkConfig.instance.getBaseUrl()}$url';
    Map<String,String> header = NetworkConfig.instance.getHttpHeader();
    http.Response response = await http.post(_url,
        headers: header,
        body: body);
    return response;
  }

  Future<http.Response> patch(url, {body}) async {
    String _url = '${NetworkConfig.instance.getBaseUrl()}${url}';
    Map<String,String> header = NetworkConfig.instance.getHttpHeader();
    http.Response response = await http.patch(_url, headers: header, body: body);
    return response;
  }

  Future<http.Response> get(url) async {
    String _url = '${NetworkConfig.instance.getBaseUrl()}${url}';
    Map<String,String> header = NetworkConfig.instance.getHttpHeader();
    http.Response response = await http.get(_url, headers: header);
    return response;
  }

  Future<http.Response> get2(url, Map parms) async {
    var parmStr = '';
    for (var entry in parms.entries) {
      parmStr = parmStr + '${entry.key}=${entry.value}&';
    }
    String _url = '${NetworkConfig.instance.getBaseUrl()}${url}?${parmStr}';
    Map<String,String> header = NetworkConfig.instance.getHttpHeader();
    http.Response response = await http.get(_url,
        headers: header);
    return response;
  }
}