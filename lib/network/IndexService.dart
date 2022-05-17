import 'package:flutter_moneyqularavel/model/Index1.dart';
import 'api.dart';
import 'dart:convert';

class IndexService{
  static String baseUrl = "/index";

  static Future<List<Index1>> getIndex1() async {
    final response = await Network().getData(baseUrl);
    List<Index1> list = parseResponse(response.body);
    return list;
  }

  static List<Index1> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Index1>((json) => Index1.fromJson(json)).toList();
  }
}