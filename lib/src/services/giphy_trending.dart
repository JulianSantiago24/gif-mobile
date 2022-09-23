import 'dart:convert';
import 'package:flutter_app_gif/src/models/gif_model.dart';
import 'package:http/http.dart' as http;

Future<List<Gif>> getTrendingGifs() async {

  List<Gif> gifs = [];
  final _url = 'api.giphy.com';
  Map<String, String> queryParams = {
    "api_key" : "sjMCiJpmuGrkJyaGC3PCt0rN1KlKhLL8",
    "limit": "20",
    "rating":"g"
  };
  
  final url = Uri.https( _url, '/v1/gifs/trending', queryParams );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    String body = utf8.decode(response.bodyBytes);
    final data = jsonDecode(body);

    for (var item in data['data']) {
      gifs.add(
        Gif(  
          item['title'],
          item['images']['downsized_medium']['url'],
          item['images']['downsized_medium']['height'],
          false
        )
      );
    }

    return gifs;

  } else {
    throw Exception('Error getting trending Gifs');
  }
}