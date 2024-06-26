import 'dart:convert';

import 'package:riverpod_bwa/models/game.dart';
import 'package:http/http.dart' as http;

class GameSource {
  static Future<List<Game>?> getLive() async {
    String url = 'https://www.freetogame.com/api/games';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list.map((e) => Game.fromJson(Map.from(e))).toList();
    }
    return null;
  }
}
