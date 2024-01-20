import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDbModel {
  ObjectId id;
  String firstName;
  String lastName;
  String address;
  String country;
  String city;
  String street;
  String? photoUrl;

  MongoDbModel({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    this.address = '',
    this.country = '',
    this.city = '',
    this.street = '',
    this.photoUrl,
  });

  factory MongoDbModel.fromRawJson(String str) =>
      MongoDbModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        street: json["street"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "country": country,
        "city": city,
        "street": street,
        "photo_url": photoUrl,
      };
}
