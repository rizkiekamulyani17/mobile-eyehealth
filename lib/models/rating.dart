class RatingResult {
  final int positif;
  final int negatif;
  final List<Review> reviews;

  RatingResult({
    required this.positif,
    required this.negatif,
    required this.reviews,
  });

  // Factory constructor to parse JSON into RatingResult
  factory RatingResult.fromJson(Map<String, dynamic> json) {
    var list = json['reviews'] as List;
    List<Review> reviewsList = list.map((i) => Review.fromJson(i)).toList();

    return RatingResult(
      positif: json['Positif'],
      negatif: json['Negatif'],
      reviews: reviewsList,
    );
  }
}

class Review {
  final String komentar;
  // final String nama;
  final String sentiment;

  Review({
    required this.komentar,
    // required this.nama,
    required this.sentiment,
  });

  // Factory constructor to parse JSON into Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      komentar: json['komentar'],
      // nama: json['nama'],
      sentiment: json['sentiment'],
    );
  }
}
