import 'package:flutter/material.dart';
import 'package:mongo_db_app/dbHelper/mongodb.dart';
import 'package:mongo_db_app/insert_data.dart';
import 'package:mongo_db_app/model/mongo_db_data.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({super.key});

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDB.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data?.length;
                return ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: totalData,
                    itemBuilder: (context, i) {
                      return cardData(MongoDbModel.fromJson(snapshot.data![i]));
                    });
              } else {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget cardData(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('${data.id.oid}'),
                Text(data.firstName),
                Text(data.lastName),
                Text(data.address),
                Text(data.country),
                Text(data.city),
                Text(data.street),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const MongoDbInsert();
                      },
                      settings: RouteSettings(arguments: data),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
