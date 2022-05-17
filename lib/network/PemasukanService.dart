import 'package:flutter_moneyqularavel/model/Pemasukan.dart';
import 'api.dart';
import 'dart:convert';

class PemasukanService{
  static String baseUrl = "/pemasukan";

  static Future<List<Pemasukan>> getpemasukan() async {
    final response = await Network().getData(baseUrl);
    List<Pemasukan> list = parseResponse(response.body);
    return list;
  }

  static List<Pemasukan> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody)['data']['data_pemasukan'].cast<Map<String, dynamic>>();
    return parsed.map<Pemasukan>((json) => Pemasukan.fromJson(json)).toList();
  }
}