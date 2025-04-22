import 'dart:convert';

class UserModel {
  UserModel({
    required this.alamat,
    required this.email,
    required this.id,
    required this.name,
    required this.role,
    required this.tanggalLahir,
    required this.tempat,
    required this.gambar,
  });

  final String? alamat;
  final String? email;
  final int? id;
  final String? name;
  final String? role;
  final String? tanggalLahir;
  final String? tempat;
  final String? gambar;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      alamat: json["alamat"],
      email: json["email"],
      id: json["id"],
      name: json["name"],
      role: json["role"],
      tanggalLahir: json["tanggal_lahir"],
      tempat: json["tempat"],
      gambar: json["profile_picture"],
    );
  }

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "email": email,
        "id": id,
        "name": name,
        "role": role,
        "tanggal_lahir": tanggalLahir.toString(),
        "tempat": tempat,
        "profile_picture": gambar,
      };

  @override
  String toString() {
    return "$alamat, $email, $id, $name, $role, $tanggalLahir, $tempat, $gambar";
  }
}
