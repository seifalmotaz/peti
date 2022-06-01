import 'package:petiapp/models/location.dart';

class User {
  User({
    this.avatar,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.location,
    this.phone,
    this.accessToken,
    this.createdAt,
    this.lastLogin,
    this.id,
  });

  String? avatar;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  Location? location;
  String? phone;
  String? accessToken;
  String? createdAt;
  String? lastLogin;
  String? id;

  bool get isLocation =>
      location != null && location!.country != null && location!.city != null;

  bool get isPhone => phone != null;

  bool get isAccountCompleted => isPhone && isLocation;

  String get username =>
      firstName![0].toUpperCase() + firstName!.substring(1) + ' ' + lastName!;

  factory User.fromMap(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
        phone: json["phone"],
        accessToken: json["access_token"],
        createdAt: json["created_at"],
        lastLogin: json["last_login"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "avatar": avatar,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "location": location == null ? null : location!.toMap(),
        "phone": phone,
        "access_token": accessToken,
        "created_at": createdAt,
        "last_login": lastLogin,
      };
}
