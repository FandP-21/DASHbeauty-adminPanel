// To parse this JSON data, do
//
//     final productResponseModel = productResponseModelFromJson(jsonString);

import 'dart:convert';

ProductsResponseModel productResponseModelFromJson(String str) => ProductsResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductsResponseModel data) => json.encode(data.toJson());

class ProductsResponseModel {
  ProductsResponseModel({
    this.data,
    this.totalReseult,
  });

  List<ProductResponseModel> data;
  int totalReseult;

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) => ProductsResponseModel(
    data: json["data"] == null ? null : List<ProductResponseModel>.from(json["data"].map((x) => ProductResponseModel.fromJson(x))),
    totalReseult: json["TotalReseult"] == null ? null :json["TotalReseult"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "TotalReseult": totalReseult,
  };
}

class ProductResponseModel {
  ProductResponseModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.description,
    this.keywords,
    this.isActive,
    this.isDeleted,
    this.createTime,
    this.updateTime,
    this.categoryId,
    this.productImages,
  });

  String id;
  String name;
  String price;
  int quantity;
  String description;
  String keywords;
  bool isActive;
  bool isDeleted;
  DateTime createTime;
  DateTime updateTime;
  CategoryId categoryId;
  List<ProductImage> productImages;

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
    id: json["id"] == null ? null :json["id"],
    name: json["name"] == null ? null :json["name"],
    price: json["price"] == null ? null :json["price"],
    quantity: json["quantity"] == null ? null :json["quantity"],
    description: json["description"] == null ? null :json["description"],
    keywords: json["keywords"] == null ? null :json["keywords"],
    isActive: json["isActive"] == null ? null :json["isActive"],
    isDeleted: json["isDeleted"] == null ? null :json["isDeleted"],
    createTime: json["createTime"] == null ? null :DateTime.parse(json["createTime"]),
    updateTime: json["updateTime"] == null ? null :DateTime.parse(json["updateTime"]),
    categoryId: json["categoryId"] == null ? null :CategoryId.fromJson(json["categoryId"]),
    productImages: json["productImages"] == null ? null :List<ProductImage>.from(json["productImages"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "quantity": quantity,
    "description": description,
    "keywords": keywords,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "categoryId": categoryId.toJson(),
    "productImages": List<dynamic>.from(productImages.map((x) => x.toJson())),
  };
}

class CategoryId {
  CategoryId({
    this.id,
    this.name,
    this.image
  });

  int id;
  String name;
  String image;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
    id: json["id"] == null ? null : json["id"],
    name: json["name"]== null ? null :json["name"],
    image: json["image"]== null ? null :json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class ProductImage {
  ProductImage({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"]== null ? null :json["id"],
    image: json["image"]== null ? null :json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}


class CreateProductRequest {
  String name = "";
  String price = "";
  String quantity = "";
  String description = "";
  String keywords;
  String categoryId;
  String resellerStoreId;

  CreateProductRequest(
      {this.name,
        this.price,
        this.quantity,
        this.description,
        this.keywords,
        this.categoryId,
        this.resellerStoreId});

  CreateProductRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    keywords = json['keywords'];
    categoryId = json['categoryId'];
    resellerStoreId = json['resellerStoreId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['keywords'] = this.keywords;
    data['categoryId'] = this.categoryId;
    data['resellerStoreId'] = this.resellerStoreId;
    return data;
  }
}
