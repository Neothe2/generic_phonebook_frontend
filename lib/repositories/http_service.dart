import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  late http.Client client;
  late String baseUrl;

  HttpService() {
    client = http.Client();
    baseUrl = "http://localhost:5129";
  }

  Future<dynamic> get(String route) async {
    final response = await client.get(Uri.parse("$baseUrl/$route"));
    return jsonDecode(response.body);
  }

  Future<dynamic> post(String route, Map<String, dynamic> body) async {
    final repsonse = await client.post(
      Uri.parse("$baseUrl/$route"),
      body: jsonEncode(body),
    );
    return jsonDecode(repsonse.body);
  }

  Future<dynamic> put(String route, Map<String, dynamic> body) async {
    final repsonse = await client.put(
      Uri.parse("$baseUrl/$route"),
      body: jsonEncode(body),
    );
    return jsonDecode(repsonse.body);
  }

  Future<dynamic> delete(String route) async {
    final repsonse = await client.delete(Uri.parse("$baseUrl/$route"));
    return jsonDecode(repsonse.body);
  }
}
