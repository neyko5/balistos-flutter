import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/home.dart';
import './models/state.model.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(BalistosApp());
}

class BalistosApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balistos',
      theme: ThemeData(
        fontFamily: "Open Sans",
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<StateModel>(
        create: (_) => StateModel(),
        child: HomePage(),
      ),
    );
  }
}
