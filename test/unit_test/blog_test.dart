import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/models/blog.dart';

void main() {
  test('Test BlogModel all article', () {
    final jsonResponse = {
      "articles": [
        {
          "id": "1",
          "judul": "Article 1",
          "gambar": "http://example.com/image1.jpg",
          "isi": "Content of article 1"
        },
        {
          "id": "2",
          "judul": "Article 2",
          "gambar": "http://example.com/image2.jpg",
          "isi": "Content of article 2"
        }
      ]
    };

    final blogModel = BlogModel.fromJson(jsonResponse);
    expect(blogModel.articles.length, 2);
  });

  test('Test BlogModel with single article', () {
    final jsonResponse = {
      "articles": {
        "id": "1",
        "judul": "Article 1",
        "gambar": "http://example.com/image1.jpg",
        "isi": "Content of article 1"
      }
    };

    final blogModel = BlogModel.fromJson(jsonResponse);
    expect(blogModel.articles.length, 1);
    expect(blogModel.articles[0].judul, "Article 1");
  });
}
