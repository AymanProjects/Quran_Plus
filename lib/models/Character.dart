class Character {
  final int id;
  final String name;
  final String about;
  final int numOfOccurances;

  Character({this.id, this.name, this.about, this.numOfOccurances});

  factory Character.fromJson(Map json) {
    if (json == null) return Character();
    return new Character(
      id: json['ID'],
      name: json['name'],
      numOfOccurances: json['occurtionNumbers'],
      about: json['about'],
    );
  }
}
