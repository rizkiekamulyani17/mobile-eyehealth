class DokterModel {
  final int id;
  final String name;
  final String profileImg;
  final String tentang;

  DokterModel({
    required this.id,
    required this.name,
    required this.profileImg,
    required this.tentang,
  });

  factory DokterModel.fromJson(Map<String, dynamic> json) {
    return DokterModel(
      id: json['id'],
      name: json['name'],
      profileImg: json['profile_img'],
      tentang: json['tentang'],
    );
  }
}
