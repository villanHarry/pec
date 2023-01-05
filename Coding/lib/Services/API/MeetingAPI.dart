import 'package:pec/Services/Models/MeetingModel.dart';
import '../../Constants/Imports.dart';
import 'package:http/http.dart' as http;

class MeetingAPI {
  static Future<bool> MeetingId(BuildContext context) async {
    var request = http.Request('GET', Uri.parse('$url/user/meeting'));

    if (await Internet.check()) {
      try {
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          http.Response r = await http.Response.fromStream(response);
          MeetingModel result = meetingModelFromJson(r.body);
          if (result.meeting.meetingId.isNotEmpty) {
            token = result.meeting.meetingId;
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
