import 'package:newsly/domain/news.dart';

class NewsDto {
  final String title;
  final String author;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String source;
  final String description;

  const NewsDto({
    required this.title,
    required this.author,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
    required this.description
  });

  factory NewsDto.fromJson(Map<String, dynamic> json) {
    return NewsDto(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      source: json['source']['name'] ?? '',
      description: json['description'] ?? ''
    );
  }

  News toDomain() {
    return News(
      title: title,
      author: author,
      image: urlToImage,
      year: publishedAt.isEmpty ? '' : publishedAt.split('-')[0],
      content: content,
      source: source,
      description: description
    );
  }
}
