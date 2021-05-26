class Sura {
  final int number;
  final String name;
  final String reason;
  final int numberOfVerses;

  Sura({this.number, this.name, this.reason, this.numberOfVerses});

  Sura fromJson(Map json){
    if (json == null) return Sura();
    return new Sura(
      number: json['number'],
      name: json['name'],
      reason : json['reason'],
      numberOfVerses : json['numberOfVerses'],
    );
  }

}
