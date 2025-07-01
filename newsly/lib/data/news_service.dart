import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:newsly/data/news_dto.dart';
import 'package:newsly/domain/news.dart';

class NewsService {
  Future<List<News>> searchNews(String query) async {
    final uri = Uri.parse(
      'https://newsapi.org/v2/everything?q=$query&apiKey=0ded32e65558448784fccdbc73039b0d&page=1&pageSize=20',
    );
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final List maps = json['articles'];
        return maps.map((map) => NewsDto.fromJson(map).toDomain()).toList();
      } else {
        return Future.error(response.statusCode);
      }
    } catch (error) {
      return Future.error(error.toString());
    }
  }
}
