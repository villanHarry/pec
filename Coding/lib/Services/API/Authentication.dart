import 'dart:convert';

import 'package:pec/Services/Models/LoginModel.dart';

import '../../Constants/Imports.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  /*static Future<bool> login(
      BuildContext context, String email, String password) async {
    if (await Internet.check()) {
      try {
        var connect = await Database().connect();
        final Map<String, String> header = {
          "Email": email,
          "Password": password
        };
        var query = await connect.collection("User").findOne(header);
        if (query == null) {
          Screen.showSnackBar(context: context, content: "User Doesn't Exist");
          connect.close();
          return false;
        } else {
          var AddUser = User()
            ..email = query["Email"]
            ..fullname = query["Fullname"]
            ..image = query["Image"];

          var box = Boxes.getUser();
          box.add(AddUser);
          connect.close();
          return true;
        }
      } catch (e) {
        Screen.showSnackBar(context: context, content: "Error: $e");
        return false;
      }
    } else {
      Screen.showSnackBar(
          context: context, content: "Internet Connection Error!");
      return false;
    }
  }*/

  /*static Future<bool> signUp(BuildContext context, String email,
      String password, String fullname, String image) async {
    try {
      var connect = await Database().connect();
      final Map<String, String> header = {"Email": email, "Password": password};
      var collection = connect.collection("User");
      var query = await collection.findOne(header);
      if (query == null) {
        await collection.insert({
          "Email": email,
          "Password": password,
          "Fullname": fullname,
          "Image": image
        });
        var AddUser = User()
          ..email = email
          ..fullname = fullname
          ..image = image;

        var box = Boxes.getUser();
        box.add(AddUser);
        connect.close();
        return true;
      } else {
        Screen.showSnackBar(context: context, content: "User Already Exist");
        connect.close();
        return false;
      }
    } catch (e) {
      Screen.showSnackBar(context: context, content: "Error: $e");
      return false;
    }
  }
}*/

  static Future<bool> login(
      BuildContext context, String email, String pass) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('$url/user/login'));
    request.body = json.encode({"email": email, "pass": pass});
    request.headers.addAll(headers);

    if (await Internet.check()) {
      try {
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          http.Response r = await http.Response.fromStream(response);
          LoginModel result = loginModelFromJson(r.body);
          if (result.user.email.isNotEmpty) {
            var AddUser = User()
              ..email = result.user.email
              ..fullname = result.user.fullname
              ..image = result.user.image
              ..userType = result.user.userType;

            var box = Boxes.getUser();
            box.add(AddUser);

            return true;
          } else {
            Screen.showSnackBar(context: context, content: result.message);
            return false;
          }
        } else {
          Screen.showSnackBar(
              context: context, content: "Error: ${response.reasonPhrase}");
          return false;
        }
      } catch (c) {
        Screen.showSnackBar(context: context, content: "Error: $c");
        return false;
      }
    } else {
      Screen.showSnackBar(
          context: context, content: "Internet Connection Error!");
      return false;
    }
  }

  static Future<bool> signUp(BuildContext context, String email, String pass,
      String fullname, String image) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$url/user/signup'));
    request.body = json.encode(
        {"email": email, "pass": pass, "fullname": fullname, "image": image});
    request.headers.addAll(headers);
    if (await Internet.check()) {
      try {
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          http.Response r = await http.Response.fromStream(response);
          LoginModel result = loginModelFromJson(r.body);
          if (result.user.email.isNotEmpty) {
            var AddUser = User()
              ..email = result.user.email
              ..fullname = result.user.fullname
              ..image = result.user.image
              ..userType = result.user.userType;

            var box = Boxes.getUser();
            box.add(AddUser);

            return true;
          } else {
            Screen.showSnackBar(context: context, content: result.message);
            return false;
          }
        } else {
          Screen.showSnackBar(
              context: context, content: "Error: ${response.reasonPhrase}");
          return false;
        }
      } catch (c) {
        Screen.showSnackBar(context: context, content: "Error: $c");
        return false;
      }
    } else {
      Screen.showSnackBar(
          context: context, content: "Internet Connection Error!");
      return false;
    }
  }
}
