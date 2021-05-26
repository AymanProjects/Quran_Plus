class Story {
  final int id;
  final String name;
  final String fullStory;

  Story({this.id, this.name, this.fullStory});

  factory Story.fromJson(Map json) {
    if (json == null) return Story();
    return new Story(
        id: json['ID'], name: json['name'], fullStory: json['fullStory']);
  }
}
