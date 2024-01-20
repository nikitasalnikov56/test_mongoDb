import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:mongo_db_app/dbHelper/mongodb.dart';
import 'package:mongo_db_app/model/mongo_db_data.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbStateInsert();
}

class _MongoDbStateInsert extends State<MongoDbInsert> {
  var fnameController = TextEditingController();
  var flastnameController = TextEditingController();
  var faddressController = TextEditingController();
  var fcountryController = TextEditingController();
  var fcityController = TextEditingController();
  var fstreetController = TextEditingController();

  var checkInsertUpdate = 'Insert';

  @override
  Widget build(BuildContext context) {
    // MongoDbModel data =
    //     ModalRoute.of(context)?.settings.arguments as MongoDbModel;
    // ignore: unnecessary_null_comparison
    // if (data != null) {
    //   fnameController.text = data.firstName;
    //   flastnameController.text = data.lastName;
    //   faddressController.text = data.address;
    //   fcountryController.text = data.country;
    //   fcityController.text = data.city;
    //   fstreetController.text = data.street;
    //   checkInsertUpdate = 'Update';
    // }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  checkInsertUpdate,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: fnameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: flastnameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: faddressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: fcountryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: fcityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: fstreetController,
                  decoration: const InputDecoration(
                    labelText: 'Street',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _fakeData();
                      },
                      child: const Text('Generate data'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (checkInsertUpdate == 'Update') {
                          // _updateData(
                          //   id: data.id,
                          //   fname: fnameController.text,
                          //   lname: flastnameController.text,
                          //   address: faddressController.text,
                          //   country: fcountryController.text,
                          //   city: fcityController.text,
                          //   street: fstreetController.text,
                          // );
                        } else {
                          _insertData(
                            fname: fnameController.text,
                            lname: flastnameController.text,
                            address: faddressController.text,
                            country: fcountryController.text,
                            city: fcityController.text,
                            street: fstreetController.text,
                          );
                        }
                      },
                      child: Text(checkInsertUpdate),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      flastnameController.text = faker.person.lastName();
      faddressController.text = faker.address.continent();
      fcountryController.text = faker.address.country();
      fcityController.text = faker.address.city();
      fstreetController.text = faker.address.streetName();
    });
  }

  Future<void> _insertData(
      {required String fname,
      required String lname,
      required String address,
      required String country,
      required String city,
      required String street}) async {
    var id = mongo.ObjectId();
    final data = MongoDbModel(
        id: id,
        firstName: fname,
        lastName: lname,
        address: address,
        country: country,
        city: city,
        street: street);

    var result = await MongoDB.insert(data);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Iserted ID: ${id.oid}, result: $result'),
      ),
    );
    clearAll();
  }
  // .then(
  //     (value) => Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const MongoDbUpdate(),
  //       ),
  //     ),
  //   )

  void clearAll() {
    fnameController.clear();
    flastnameController.clear();
    faddressController.clear();
    fcountryController.clear();
    fcityController.clear();
    fstreetController.clear();
  }

  Future<void> _updateData(
      {var id,
      required String fname,
      required String lname,
      required String address,
      required String country,
      required String city,
      required String street}) async {
    final updateData = MongoDbModel(
        id: id,
        firstName: fname,
        lastName: lname,
        address: address,
        country: country,
        city: city,
        street: street);
    await MongoDB.update(updateData).whenComplete(() => Navigator.pop(context));
  }
}
