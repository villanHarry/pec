import '../Constants/Imports.dart';

class Screen {
  static push(BuildContext context, Widget Screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Screen));
  }

  static replace(BuildContext context, Widget Screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Screen));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static popallstack(BuildContext context, Widget Screen) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Screen));
  }

  static showSnackBar(
      {required BuildContext context, required String content}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Padding(
          padding: EdgeInsets.only(
            // top: height * 0.6,
            left: width * 0.015,
            right: width * 0.015,
            bottom: 0,
          ),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: width * 0.03),
              // ignore: sort_child_properties_last
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: SizedBox(
                      width: width * 0.5,
                      child: Text(
                        content,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )));
  }
}
