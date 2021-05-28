class Sura {
  final int number;
  final String name;
  final String type;
  final String reason;
  final int numberOfVerses;

  Sura({this.number, this.name, this.reason, this.numberOfVerses, this.type});

  factory Sura.fromJson(Map json) {
    if (json == null) return Sura();
    return new Sura(
      number: json['number'],
      type: json['type'],
      name: json['name'],
      reason: json['reason'],
      numberOfVerses: json['numberOfVerses'],
    );
  }
}
