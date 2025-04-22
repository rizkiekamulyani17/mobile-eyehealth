import 'package:Eye_Health/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article; // Receive the article passed as an argument

  ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.judul ?? "Article Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the article image if it exists
            if (article.gambar != null && article.gambar!.isNotEmpty)
              Image.network(
                article.gambar!,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            // Display the article title
            Text(
              article.judul ?? "No Title",
            ),
            SizedBox(height: 16),
            // Render the HTML content of the article
            Html(
              data: article.isi ?? "No content available.",
            ),
          ],
        ),
      ),
    );
  }
}
