class FoodModel {
  String? id;
  String? name;
  String? images;

  FoodModel({
    this.id,
    this.name,
    this.images,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    // name = json['display']['displayName'];
    // images = json['display']['images'][0];
    //id = json[];
    name = json['display']['displayName'];
    images = json['display']['images'][0];
  }
}
