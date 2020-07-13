
class ProductModel {
  ProductModel({
    this.categories,
  });

  List<Category> categories;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}



class Category {
  Category({
    this.name,
    this.contents,
  });

  String name;
  List<Content> contents;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    contents: List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
  };
}

class Content {
  Content({
    this.brandName,
    this.title,
    this.price,
    this.imgPath,
  });

  String brandName;
  String title;
  int price;
  String imgPath;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    brandName: json["category"],
    title: json["title"],
    price: json["price"],
    imgPath: json["imgPath"],
  );

  Map<String, dynamic> toJson() => {
    "category": brandName,
    "title": title,
    "price": price,
    "imgPath": imgPath,
  };
}