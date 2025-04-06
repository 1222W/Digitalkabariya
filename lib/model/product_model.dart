class ProductModel {
  List<String> images;
  String name;
  String description;
  String number;
  String secondNum;
  String price;
  String address;
  String voice;
  String? docId; // Optional field
  final double? lat, lng; // Optional latitude and longitude
  bool? isSold;

  ProductModel({
    required this.images,
    required this.name,
    required this.description,
    required this.number,
    required this.secondNum,
    required this.price,
    required this.address,
    required this.voice,
    this.docId,
    this.lat,
    this.lng,
    this.isSold,
  });

  // Factory constructor to parse JSON with null checks
  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
      images: (json["images"] as List<dynamic>?)
              ?.map((x) => x.toString())
              .toList() ??
          [], // Default to an empty list if null
      name: json["name"] ?? "Unknown Name", // Default value if null
      description: json["description"] ?? "No Description",
      number: json["number"] ?? "N/A",
      secondNum: json["secondNum"] ?? "N/A",
      price: json["price"] ?? "0", // Default price if null
      address: json["address"] ?? "No Address",
      voice: json["voice"] ?? "", // Default to empty string
      lat: json["lat"] != null ? json["lat"] as double : null,
      lng: json["lng"] != null ? json["lng"] as double : null,
      isSold: json['isSold'] as bool?, // No default, keep nullable
      docId: id, // Document ID from Firebase
    );
  }

  // Convert to JSON with null safety
  Map<String, dynamic> toJson() {
    return {
      "images": images.map((x) => x).toList(),
      "name": name,
      "description": description,
      "number": number,
      "secondNum": secondNum,
      "price": price,
      "address": address,
      "voice": voice,
      "lat": lat,
      "lng": lng,
      "isSold": isSold,
    };
  }
}
