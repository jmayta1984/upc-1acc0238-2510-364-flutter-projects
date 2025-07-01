import 'package:newsly/domain/favorite_news.dart';

class FavoriteNewsDto {
  final String title;
  final String author;
  final String image;
  final String description;

  const FavoriteNewsDto({
    required this.author,
    required this.description,
    required this.image,
    required this.title,
  });

  factory FavoriteNewsDto.fromDatabase(Map<String, dynamic> map) {
    return FavoriteNewsDto(
      author: map['author'],
      description: map['description'],
      image: map['image'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'image': image,
    };
  }

  FavoriteNews toDomain() {
    return FavoriteNews(
      author: author,
      description: description,
      image: image,
      title: title,
    );
  }
}
