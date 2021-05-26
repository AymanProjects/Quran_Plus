class Location {
  final int id;
  final String name;

  Location({this.id, this.name});

  factory Location.fromJson(Map json) {
    if (json == null) return Location();
    return new Location(
      id: json['ID'],
      name: json['name'],
    );
  }
}
