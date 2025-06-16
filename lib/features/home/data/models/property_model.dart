class PropertyModel {
  String? id;
  String? title;
  String? description;
  String? city;
  String? locationLink;
  String? managementCompany;
  String? status;
  String? investmentDocs;
  String? rentalName;
  String? rentalStartDate;
  String? rentalEndDate;
  String? estimatedExitDate;
  int? size;
  int? numberOfRooms;
  int? numberOfbeds;
  int? numberOfKitchens;
  int? numberOfBathrooms;
  int? totalShares;
  int? availableShares;
  num? yearlyPayment;
  num? rentalIncome;
  num? price;
  num? pricePerShare;
  num? priceSold;
  num? area;
  bool? isRented;
  List<dynamic>? benefits;
  List<dynamic>? images;

  PropertyModel({
    this.id,
    this.title,
    this.description,
    this.city,
    this.locationLink,
    this.managementCompany,
    this.status,
    this.investmentDocs,
    this.size,
    this.numberOfRooms,
    this.totalShares,
    this.images,
    this.availableShares,
    this.yearlyPayment,
    this.price,
    this.pricePerShare,
    this.benefits,
    this.priceSold,
    this.isRented,
    this.estimatedExitDate,
    this.rentalEndDate,
    this.rentalIncome,
    this.rentalName,
    this.rentalStartDate,
    this.numberOfbeds,
    this.numberOfKitchens,
    this.numberOfBathrooms,
    this.area,
  });

  PropertyModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    city = json['city'];
    locationLink = json['locationLink'];
    managementCompany = json['managementCompany'];
    status = json['status'];
    investmentDocs = json['investmentDocs'];
    size = json['size'];
    numberOfRooms = json['numOfRooms'];
    totalShares = json['totalShares'];
    availableShares = json['availableShares'];
    yearlyPayment = json['yearlyPayment'];
    price = json['price'][0];
    pricePerShare = json['pricePerShare'][0];
    benefits = json['benefits'];
    priceSold = json['priceSold'];
    isRented = json['isRented'];
    estimatedExitDate = json['estimatedExitDate'];
    images = json['images'];
    rentalEndDate = json['rentalEndDate'];
    rentalIncome = json['rentalIncome'];
    rentalName = json['rentalName'];
    rentalStartDate = json['rentalStartDate'];
    numberOfbeds = json['numOfbeds'];
    numberOfKitchens = json['numOfKitchens'];
    numberOfBathrooms = json['numOfBathrooms'];
    area = json['area'];
  }

  @override
  String toString() {
    return "PropertyModel {"
        "id: $id,"
        "title: $title,"
        "description: $description,"
        "city: $city,"
        "locationLink: $locationLink,"
        "managementCompany: $managementCompany,"
        "status: $status,"
        "investmentDocs: $investmentDocs,"
        "size: $size,"
        "numberOfRooms: $numberOfRooms,"
        "totalShares: $totalShares,"
        "availableShares: $availableShares,"
        "yearlyPayment: $yearlyPayment,"
        "price: $price,"
        "pricePerShare: $pricePerShare,"
        "benefits: $benefits,"
        "priceSold: $priceSold,"
        "isRented: $isRented,"
        "estimatedExitDate: $estimatedExitDate,"
        "images: $images,"
        "rentalEndDate: $rentalEndDate,"
        "rentalIncome: $rentalIncome,"
        "rentalName: $rentalName,"
        "rentalStartDate: $rentalStartDate"
        "numberOfbeds: $numberOfbeds,"
        "numberOfKitchens: $numberOfKitchens,"
        "numberOfBathrooms: $numberOfBathrooms,"
        "area: $area"
        "}";
  }
}
