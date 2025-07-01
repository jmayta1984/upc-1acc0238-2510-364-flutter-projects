import 'package:flutter/material.dart';
import 'package:newsly/data/news_service.dart';
import 'package:newsly/domain/news.dart';
import 'package:newsly/presentation/news_detail_page.dart';

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({super.key});

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  List<News> _newsList = [];

  Future<void> _onSearchNews(String query) async {
    List<News> newsList = await NewsService().searchNews(query);
    setState(() {
      _newsList = newsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search news',
          ),
          onSubmitted: _onSearchNews,
        ),
        Expanded(child: NewsListView(newsList: _newsList)),
      ],
    );
  }
}

class NewsListView extends StatelessWidget {
  const NewsListView({super.key, required this.newsList});

  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final News news = newsList[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewsDetailPage(news: news)),
          ),
          child: NewsListItemView(news: news),
        );
      },
    );
  }
}

class NewsListItemView extends StatelessWidget {
  const NewsListItemView({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: SizedBox(
              height: 120,
              child: Image.network(
                news.image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  news.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Author: ${news.author}'),
                Text(news.year, style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
