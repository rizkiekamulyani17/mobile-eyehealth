class BlogModel {
  BlogModel({
    required this.articles, // This can hold a list of articles
  });

  final List<Article> articles;

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    // Check if the 'articles' field is a list or a single object
    if (json['articles'] is List) {
      return BlogModel(
        articles: List<Article>.from(
            json['articles'].map((x) => Article.fromJson(x))),
      );
    } else if (json['articles'] is Map) {
      return BlogModel(
        articles: [
          Article.fromJson(json['articles'])
        ], // Wrap in a list if it's a single article
      );
    } else {
      throw Exception("Invalid 'articles' structure in API response");
    }
  }

  Map<String, dynamic> toJson() => {
        'articles': articles.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$articles";
  }
}

class Article {
  Article({
    required this.gambar,
    required this.id,
    required this.isi,
    required this.judul,
  });

  final String? gambar;
  final String? id;
  final String? isi;
  final String? judul;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      gambar: json["gambar"], // Can be null
      id: json["id"]?.toString(),
      isi: json["isi"],
      judul: json["judul"],
    );
  }

  Map<String, dynamic> toJson() => {
        "gambar": gambar,
        "id": id,
        "isi": isi,
        "judul": judul,
      };

  @override
  String toString() {
    return "$gambar, $id, $isi, $judul, ";
  }
}
