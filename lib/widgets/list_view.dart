import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mock_mid/models/model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              semanticLabel: 'menu',
              color: Colors.white,
            ),
            onPressed: () {
              print('Menu button');
            },
          ),
          title: const Text(
            'Products',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 157, 100, 167),
        ),
        body: Center(
            child: FutureBuilder<List<APIDataModel>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (contxt, i) {
                          var item = snapshot.data![i];
                          // return Text(item.name ?? '');
                          return productItem(item);
                        });
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  }

                  return const CircularProgressIndicator();
                })));
  }

  Widget productItem(APIDataModel obj) {
    return Card(
        child: ListTile(
      leading: Image.network(obj.imageLink ?? ''),
      title: Text(obj.name ?? ''),
      trailing: Text(
        '\$${obj.price ?? ''}',
        style: const TextStyle(fontSize: 15),
      ),
    ));
  }
}

Future<List<APIDataModel>> fetchProducts() async {
  final response = await http.get(Uri.parse(
      'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));

  // print(response.body.toString());

  if (response.statusCode == 200) {
    List<dynamic> _parsedListJson = jsonDecode(response.body);

    List<APIDataModel> _itemsList = List<APIDataModel>.from(_parsedListJson
        .map<APIDataModel>((dynamic i) => APIDataModel.fromJson(i)));

    return _itemsList;
  } else {
    throw Exception('Failed to load Users');
  }
}
