import 'package:flutter_auth/model/Index.dart';
import 'api.dart';
import 'dart:convert';

class StudentService{
  static String baseUrl = "/index";

  static Future<List<Index>> getStudent() async {
    final response = await Network().getData(baseUrl);
    List<Index> list = parseResponse(response.body);
    return list;
  }

  static List<Index> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Index>((json) => Index.fromJson(json)).toList();
  }
}