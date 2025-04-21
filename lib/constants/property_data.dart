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

List<PropertyModel> data = [
  // From 'Best for you' category
  PropertyModel(
    name: "Apartment",
    price: 2670.0,
    location: "New York, USA",
    size: 2000,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment B",
    price: 2550.0,
    location: "New York, USA",
    size: 2100,
    bedrooms: 3,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment C",
    price: 29400.0,
    location: "New York, USA",
    size: 1900,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment D",
    price: 28900.0,
    location: "New York, USA",
    size: 2200,
    bedrooms: 5,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment E",
    price: 2656.0,
    location: "New York, USA",
    size: 2000,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment 5",
    price: 2656.0,
    location: "New York, USA",
    size: 2000,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment 7",
    price: 2656.0,
    location: "New York, USA",
    size: 2000,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Apartment 9",
    price: 2656.0,
    location: "New York, USA",
    size: 2000,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),

  // From 'New Added' category
  PropertyModel(
    name: "Studio M",
    price: 1500.0,
    location: "New York, USA",
    size: 800,
    bedrooms: 1,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Studio N",
    price: 1600.0,
    location: "New York, USA",
    size: 850,
    bedrooms: 1,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Studio O",
    price: 150.0,
    location: "New York, USA",
    size: 820,
    bedrooms: 1,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Studio P",
    price: 1650.0,
    location: "New York, USA",
    size: 870,
    bedrooms: 1,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Studio Q",
    price: 1700.0,
    location: "New York, USA",
    size: 900,
    bedrooms: 2,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),

  // From 'Best Invest' category
  PropertyModel(
    name: "Penthouse J",
    price: 503.0,
    location: "New York, USA",
    size: 4000,
    bedrooms: 6,
    bathrooms: 4,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Penthouse K",
    price: 484.0,
    location: "New York, USA",
    size: 3800,
    bedrooms: 5,
    bathrooms: 3,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Penthouse L",
    price: 924.0,
    location: "New York, USA",
    size: 4100,
    bedrooms: 6,
    bathrooms: 4,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Penthouse M",
    price: 1943.0,
    location: "New York, USA",
    size: 3700,
    bedrooms: 5,
    bathrooms: 3,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Penthouse N",
    price: 4913.0,
    location: "New York, USA",
    size: 4200,
    bedrooms: 7,
    bathrooms: 5,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),

  // From 'MORSHEDY GROUP' developer
  PropertyModel(
    name: "Dup Apartment",
    price: 2670.0,
    location: "28W Street, NY, New York",
    size: 2000,
    bedrooms: 4,
    bathrooms: 1,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Dup p",
    price: 267000.0,
    location: "28W Street, NY, New York",
    size: 2000,
    bedrooms: 3,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Dup h",
    price: 267000.0,
    location: "28W Street, NY, New York",
    size: 2000,
    bedrooms: 3,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),

  // From 'ANA GROUP' developer
  PropertyModel(
    name: "Dup Apartment",
    price: 267000.0,
    location: "28W Street, NY, New York",
    size: 2000,
    bedrooms: 3,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Dup p",
    price: 267000.0,
    location: "28W Street, NY, New York",
    size: 2000,
    bedrooms: 3,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
  PropertyModel(
    name: "Dup h",
    price: 267000.0,
    location: "28W Street, NY, New York",
    size: 2000,
    bedrooms: 3,
    bathrooms: 2,
    kitchens: 1,
    image:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU",
  ),
];