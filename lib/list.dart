import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:local/test.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  void initState() {
    final test = Hive.box('location');
    mymap = test.toMap().values.toList();
    Future(() async {
      await Future.delayed(Duration(milliseconds: 100));
      all_item();

      print("inistare");
      print(mymap);
      setState(() {
        data = mymap;
      });
      // print(test.values.length);
      // print(test.values);
    });
  }

  List itemlist = [];
  List data = [];

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            int new_index = index + 1;
            return Card(
              child: ListTile(
                leading: Text(new_index.toString()),
                title: Text(data[index]["item_name"]),
                subtitle: Text(data[index]["stock_uom"]),

                // Text(
                //     data[index]["item_code"] + " " + data.length.toString());
              ),
            );
          }),
    );
  }

  Future all_item() async {
    var response = await http.get(
        Uri.parse(
            """https://fargodev.thirvusoft.co.in/api/method/retail_app.custom.py.api.api_list.all_item_list"""),
        headers: {"Authorization": "token 5fbc807b69674df:3de4edb08e8f18f"});

    if (response.statusCode == 200) {
      itemlist = [];

      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        itemloading = false;

        for (var i = 0; i < json.decode(response.body)['message'].length; i++) {
          itemlist.add((json.decode(response.body)['message'][i]));
        }

        put_data(itemlist);
        print("sssssss");
        print(itemlist.length);
      });
      final location = Hive.box('location');
      setState(() {
        Future(() async {
          await Future.delayed(Duration(milliseconds: 100));
          mymap = location.toMap().values.toList();
        });

        print(mymap);
        data = mymap;
      });
    } else {
      print("itemlistttt");
      print(itemlist);

      put_data(itemlist);
      return json.decode(response.body)['message'];
    }
  }

  Future put_data(data) async {
    print(data);
    final location = Hive.box('location');

    await location.clear();

    print("1");
    for (var i in data) {
      print(local);
      print(i);
      print("2");
      await location.add(i);
      print("check");
    }
    print(location.values);

    // print(itemlist.length);
    // final list_hive = Hive.box('location');
    // Hive.box('location').clear();

    // list_hive.add((itemlist));
    // setState(() {
    //   map = list_hive.toMap().values.toList();
    // });
    // print(list_hive.values);
    // print(map);
    // print("map.lengthhhh");
    // print(map.length);
    // print("fffffffffffffffffffffffff");
    // // if (map.isEmpty) {
    // //   data.add("empty");
    // // } else {
    // //   setState(() {
    // //     data = map;
    // //   });
    // //   print("lengh");

    // //   print(data.length);
    // // }
  }
}
