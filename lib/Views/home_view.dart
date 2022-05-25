import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_provider/Models/user_login_response.dart';
import 'package:shared_preferences_provider/Widgets/app_text_form_fields.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController usernameController = TextEditingController();
  final String dataKey = "USER_DATA";

  @override
  void initState() {
    loadFromLocal();
    super.initState();
  } // initState

  // when application restart
  loadFromLocal() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(dataKey)) {

      AppUser user = AppUser.fromJson(jsonDecode(prefs.getString(dataKey) ?? ""));

      usernameController.text = user.accessToken ?? "";
    }
  } // loadFromLocal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              AppTextFields(
                hintText: "User Name",
                controller: usernameController,
                validator: (value) =>
                    (value?.isEmpty ?? true) ? "Please Enter Your Name" : null,
              ),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () => saveDataLocally(context),
                  child: Text("Save"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  } // build

  void saveDataLocally(BuildContext context) async {
    if (Form.of(context)!.validate()) {

      String jsonResponse = '''
      {
    "message": "Success",
    "statusCode": 200,
    "data": {
        "id": 5,
        "email": "hello@gmail.com",
        "phone": "123",
        "password": "123456",
        "accessToken": "bc41687e-082f-4582-a7ff-b897838446de"
    }
      }''';

      var response = UserLoginResponse.fromJson(jsonDecode(jsonResponse));
      
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();

      // Save an integer value to 'counter' key.
      await prefs.setString(dataKey, jsonEncode(response.data?.toJson()));
    }
  } // saveDataLocally
} // HomeView
