import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_app/dbHelper/constants.dart';
import 'package:mongo_db_app/model/mongo_db_data.dart';

class MongoDB {
  static dynamic db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);

    await db.open();

    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var res = await userCollection.insertOne(data.toJson());
      if (res.isSuccess) {
        return "Data inserted";
      } else {
        return "Something wrong";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //fetch data
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  //update data
  static Future<void> update(MongoDbModel data) async {
    try {
      // var result = await userCollection.findOne({"_id": data.id});
      var dataToUpdate = {
        'firstName': data.firstName,
        'lastName': data.lastName,
        'address': data.address,
        'country': data.country,
        'city': data.city,
        'street': data.street,
      };
      var selector = where.eq("_id", data.id);
      var modifier = {
        r'$set': dataToUpdate,
      };
      var response = await userCollection.update(selector, modifier);
      inspect(response);
      // await db.close();
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
    }
  }

  static Future<void> delete(MongoDbModel data) async {
    try {
      await userCollection.remove(where.eq("_id", data.id));
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
    }
  }
}
