class Verse {
  final int verseNumber;
  final int suraNumber;
  final int storyID;
  final int locationID;

  final String verse;
  final String tafseer;

  Verse(
      {this.verseNumber,
      this.suraNumber,
      this.storyID,
      this.locationID,
      this.verse,
      this.tafseer});

  factory Verse.fromJson(Map json) {
    if (json == null) return Verse();
    return new Verse(
      verseNumber: json['verseNumber'],
      suraNumber: json['suraNumber'],
      storyID: json['storyID'],
      locationID: json['locationID'],
      verse: json['verse'],
      tafseer: json['tafseer'],
    );
  }
}
