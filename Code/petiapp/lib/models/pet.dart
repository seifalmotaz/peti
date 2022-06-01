import 'user.dart';

class Pet {
  Pet(
      {this.avatar,
      this.name,
      this.birthday,
      this.gender,
      this.type,
      this.breed,
      this.wantMarraige,
      this.owner,
      this.createdAt,
      this.likes,
      this.followers,
      this.id});

  String? avatar;
  String? name;
  String? birthday;
  String? gender;
  String? type;
  String? breed;
  bool? wantMarraige;
  User? owner;
  String? createdAt;
  int? likes;
  int? followers;
  String? id;

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        avatar: json["avatar"],
        name: json["name"],
        birthday: json["birthday"],
        gender: json["gender"],
        type: json["type"],
        likes: json["likes"],
        followers: json["followers"],
        breed: json["breed"] == null ? null : json["breeds"],
        wantMarraige: json["want_marraige"],
        owner: json["owner"] == null
            ? json["owner_id"] == null
                ? null
                : User(id: json["owner_id"])
            : User.fromMap(json["owner"]),
        createdAt: json["created_at"],
        id: json["id"],
      );

  String get birthDate => birthday!.split('T')[0];

  String get birthText => 'Birthday: $birthDate';
}
