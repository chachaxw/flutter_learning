import 'package:http/http.dart' as http;

class ApiService {

  static const String category = 'bitcoin';
  static const String apiKey = '3a380307164047389f8a34c2827b42fa';
  static const String sortBy = 'publishedAt';
  final String url = 'https://newsapi.org/v2/everything?q=$category&from=2019-03-04&sortBy=$sortBy&apiKey=$apiKey';

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