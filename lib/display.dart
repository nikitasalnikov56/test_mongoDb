import 'package:flutter/material.dart';
import 'package:mongo_db_app/dbHelper/mongodb.dart';
import 'package:mongo_db_app/model/mongo_db_data.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return displayCard(
                            MongoDbModel.fromJson(snapshot.data![i]));
                      });
                } else {
                  return const Center(
                    child: Text('No data Available'),
                  );
                }
              }
            }),
      ),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
      ),
    );
  }
}
