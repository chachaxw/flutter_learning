import 'package:http/http.dart' as http;

class ApiService {

  static const String sources = 'techcrunch';
  static const String apiKey = '3a380307164047389f8a34c2827b42fa';
  final String url = 'https://newsapi.org/v2/top-headlines?sources=$sources&apiKey=$apiKey';

  // Function to get the JSON data
  Future<http.Response> getNewsData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json",
      }
    );

    return response;
  }

}