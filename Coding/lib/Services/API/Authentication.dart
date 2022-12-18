import '../../Constants/Imports.dart';

class AuthAPI {
  static Future<bool> login(
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
  }

  static Future<bool> signUp(BuildContext context, String email,
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
}
