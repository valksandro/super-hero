
class HeroModel {
  final String id;
  final String name;
  final String image;
  final PowerStats powerStats;
  final Biography biography;
  final Appearance appearance;

  HeroModel({this.id, this.name, this.image, this.powerStats, this.biography, this.appearance});

  HeroModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    image = json['image']['url'],
    powerStats = PowerStats.fromJson(json['powerstats']),
    biography = Biography.fromJson(json['biography']),
    appearance = Appearance.fromJson(json['appearance']);
}

class PowerStats {
  String intelligence;
  String strength;
  String speed;
  String durability;
  String power;
  String combat;

  PowerStats(
      {this.intelligence,
        this.strength,
        this.speed,
        this.durability,
        this.power,
        this.combat});

  PowerStats.fromJson(Map<String, dynamic> json) {
    intelligence = json['intelligence'];
    strength = json['strength'];
    speed = json['speed'];
    durability = json['durability'];
    power = json['power'];
    combat = json['combat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intelligence'] = this.intelligence;
    data['strength'] = this.strength;
    data['speed'] = this.speed;
    data['durability'] = this.durability;
    data['power'] = this.power;
    data['combat'] = this.combat;
    return data;
  }
}

class Biography {
  String fullName;
  String alterEgos;
  List<String> aliases;
  String placeOfBirth;
  String firstAppearance;
  String publisher;
  String alignment;

  Biography(
      {this.fullName,
        this.alterEgos,
        this.aliases,
        this.placeOfBirth,
        this.firstAppearance,
        this.publisher,
        this.alignment});

  Biography.fromJson(Map<String, dynamic> json) {
    fullName = json['full-name'];
    alterEgos = json['alter-egos'];
    aliases = json['aliases'].cast<String>();
    placeOfBirth = json['place-of-birth'];
    firstAppearance = json['first-appearance'];
    publisher = json['publisher'];
    alignment = json['alignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full-name'] = this.fullName;
    data['alter-egos'] = this.alterEgos;
    data['aliases'] = this.aliases;
    data['place-of-birth'] = this.placeOfBirth;
    data['first-appearance'] = this.firstAppearance;
    data['publisher'] = this.publisher;
    data['alignment'] = this.alignment;
    return data;
  }
}

class Appearance {
  String gender;
  String race;
  List<String> height;
  List<String> weight;
  String eyeColor;
  String hairColor;

  Appearance(
      {this.gender,
        this.race,
        this.height,
        this.weight,
        this.eyeColor,
        this.hairColor});

  Appearance.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    race = json['race'];
    height = json['height'].cast<String>();
    weight = json['weight'].cast<String>();
    eyeColor = json['eye-color'];
    hairColor = json['hair-color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['race'] = this.race;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['eye-color'] = this.eyeColor;
    data['hair-color'] = this.hairColor;
    return data;
  }
}


