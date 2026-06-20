import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {
  late http.Client client;
  late String baseUrl;

  HttpService() {
    client = http.Client();
    baseUrl = "http://localhost:5129";
  }

  Future<Map<String, dynamic>> get(String route) async {
    final response = await client.get(Uri.parse("$baseUrl/$route"));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
    String route,
    Map<String, dynamic> body,
  ) async {
    final repsonse = await client.post(
      Uri.parse(route),
      body: jsonEncode(body),
    );
    return jsonDecode(repsonse.body);
  }

  Future<Map<String, dynamic>> put(
    String route,
    Map<String, dynamic> body,
  ) async {
    final repsonse = await client.put(Uri.parse(route), body: jsonEncode(body));
    return jsonDecode(repsonse.body);
  }

  Future<Map<String, dynamic>> delete(String route) async {
    final repsonse = await client.delete(Uri.parse(route));
    return jsonDecode(repsonse.body);
  }
}
