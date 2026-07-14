class MyPlant {
  int? id;
  int? apiId;
  String name;
  String scientificName;
  String imageUrl;
  String localImagePath;
  String localVideoPath;
  String watering;
  String sunlight;
  String note;
  String createdAt;
  String latitude;
  String longitude;

  MyPlant({
    this.id,
    this.apiId,
    required this.name,
    required this.scientificName,
    required this.imageUrl,
    required this.localImagePath,
    this.localVideoPath = "",
    required this.watering,
    required this.sunlight,
    required this.note,
    required this.createdAt,
    this.latitude = "",
    this.longitude = "",
  });

  factory MyPlant.fromMap(Map<String, dynamic> map) => MyPlant(
        id: map["id"],
        apiId: map["api_id"],
        name: map["name"] ?? "",
        scientificName: map["scientific_name"] ?? "",
        imageUrl: map["image_url"] ?? "",
        localImagePath: map["local_image_path"] ?? "",
        localVideoPath: map["local_video_path"] ?? "",
        watering: map["watering"] ?? "",
        sunlight: map["sunlight"] ?? "",
        note: map["note"] ?? "",
        createdAt: map["created_at"] ?? "",
        latitude: map["latitude"] ?? "",
        longitude: map["longitude"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "api_id": apiId,
        "name": name,
        "scientific_name": scientificName,
        "image_url": imageUrl,
        "local_image_path": localImagePath,
        "local_video_path": localVideoPath,
        "watering": watering,
        "sunlight": sunlight,
        "note": note,
        "created_at": createdAt,
        "latitude": latitude,
        "longitude": longitude,
      };
}
