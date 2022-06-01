class Location {
  Location({
    this.id,
    this.iso,
    this.country,
    this.region,
    this.city,
    this.specifics,
  });

  String? id;
  String? iso;
  String? country;
  String? region;
  String? city;
  SpecificsField? specifics;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json["id"],
        iso: json["iso"],
        country: json["country"],
        region: json["region"],
        city: json["city"],
        specifics: json["specifics"] == null
            ? null
            : SpecificsField.fromMap(json["specifics"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "iso": iso,
        "country": country,
        "region": region,
        "city": city,
        "specifics": specifics == null ? null : specifics!.toMap(),
      };

  bool get isSpecific => specifics != null;
}

class SpecificsField {
  SpecificsField({
    this.type,
    this.coordinates,
  });

  String? type;
  List? coordinates;

  factory SpecificsField.fromMap(Map<String, dynamic> json) => SpecificsField(
        type: json["type"],
        coordinates: json["coordinates"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": coordinates,
      };
}
