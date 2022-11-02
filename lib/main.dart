import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local/test.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';
import 'list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
var appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.initFlutter();
    Box local;
    local = await Hive.openBox('location');
    print("xxxxxxxxxxxxxxxxx");
    Hive.registerAdapter(itemlistAdapter());
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: list(),
    );
  }
}
