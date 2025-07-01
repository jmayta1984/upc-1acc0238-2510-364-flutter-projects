import 'package:flutter/material.dart';
import 'package:newsly/data/favorite_news_dao.dart';
import 'package:newsly/domain/news.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key, required this.news});
  final News news;

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    _isFavorite
        ? FavoriteNewsDao().removeFavoriteNews(widget.news.title)
        : FavoriteNewsDao().addFavoriteNews(widget.news);
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  Future<void> _checkFavorite() async {
    bool isFavorite = await FavoriteNewsDao().checkFavorite(widget.news.title);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final News news = widget.news;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: OutlinedButton(
        onPressed: () {
          _toggleFavorite();
        },
        child: Text(_isFavorite ? 'Remove from favorites' : 'Add to favorites'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                news.image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              Text(news.content),
            ],
          ),
        ),
      ),
    );
  }
}
