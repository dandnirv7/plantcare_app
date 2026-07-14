class Plant {
  int apiId;
  String name;
  String scientificName;
  String imageUrl;
  String watering;
  String sunlight;
  String description;

  Plant({
    required this.apiId,
    required this.name,
    required this.scientificName,
    required this.imageUrl,
    required this.watering,
    required this.sunlight,
    required this.description,
  });

  factory Plant.fromMap(Map<String, dynamic> map) {
    String scientificNameText = "Data tidak tersedia";
    if (map["scientific_name"] != null && map["scientific_name"] is List) {
      List scientificNames = map["scientific_name"];
      if (scientificNames.isNotEmpty) {
        scientificNameText = scientificNames.join(", ");
      }
    } else if (map["scientific_name"] != null) {
      scientificNameText = map["scientific_name"].toString();
    }

    String imageUrlText = "";
    if (map["default_image"] != null && map["default_image"] is Map) {
      imageUrlText = map["default_image"]["regular_url"] ?? "";
    }

    String sunlightText = "Data sunlight tidak tersedia";
    if (map["sunlight"] != null && map["sunlight"] is List) {
      List sunlightList = map["sunlight"];
      if (sunlightList.isNotEmpty) {
        sunlightText = sunlightList.join(", ");
      }
    } else if (map["sunlight"] != null) {
      sunlightText = map["sunlight"].toString();
    }

    String wateringText = "Data watering tidak tersedia";
    if (map["watering"] != null && map["watering"].toString().isNotEmpty) {
      wateringText = map["watering"].toString();
    }

    String descriptionText = "Data deskripsi tidak tersedia";
    if (map["description"] != null && map["description"].toString().isNotEmpty) {
      descriptionText = map["description"].toString();
    }

    return Plant(
      apiId: map["id"] ?? 0,
      name: map["common_name"] ?? "Tanaman tanpa nama",
      scientificName: scientificNameText,
      imageUrl: imageUrlText,
      watering: wateringText,
      sunlight: sunlightText,
      description: descriptionText,
    );
  }

  Map<String, dynamic> toMap() => {
        "apiId": apiId,
        "name": name,
        "scientificName": scientificName,
        "imageUrl": imageUrl,
        "watering": watering,
        "sunlight": sunlight,
        "description": description,
      };
}
