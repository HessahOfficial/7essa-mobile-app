class PropertyModel {
  final String name;
  final double price;
  final String? location;
  final int size;
  final int bedrooms;
  final int bathrooms;
  final int? kitchens;
  final String? image;

  PropertyModel({
    required this.name,
    required this.price,
    this.location,
    required this.size,
    required this.bedrooms,
    required this.bathrooms,
    this.kitchens,
    this.image,
  });
}
