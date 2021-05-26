class Character {
  final int id;
  final String name;
  final String about;

  Character({this.id, this.name, this.about});

  factory Character.fromJson(Map json) {
    if (json == null) return Character();
    return new Character(
      id: json['ID'],
      name: json['name'],
      about: json['about'],
    );
  }
}
