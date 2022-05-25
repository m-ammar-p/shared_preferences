import 'package:flutter/material.dart';
import 'package:shared_preferences_provider/Views/home_view.dart';

void main() {
  runApp(const SharedPreferences());
}

class SharedPreferences extends StatelessWidget {
  const SharedPreferences({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  } // build
} // SharedPreferences
