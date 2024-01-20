import 'package:flutter/material.dart';
import 'package:mongo_db_app/dbHelper/mongodb.dart';
import 'package:mongo_db_app/model/mongo_db_data.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({super.key});

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
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
                _deleteData(data.id);
                setState(() {});
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteData(var id) async {
    final deleteDataValues = MongoDbModel(id: id);

    await MongoDB.delete(deleteDataValues);
  }
}
