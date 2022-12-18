import '../Constants/Imports.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      if (Boxes.getUser().values.cast<User>().first != null) {
        Screen.replace(context, const HomeScreen());
      } else {
        Screen.replace(context, const WelcomeScreen());
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6587F2),
                  Color(0xFF4C48EE),
                ],
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.width * 0.5,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                direction: ShimmerDirection.ttb,
                highlightColor: const Color(0xFF5763EE),
                child: Image.asset(
                  Assets.logo,
                  scale: 1.5,
                  color: white,
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.width * 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pakistan Engineering",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: thin,
                    fontSize: 16,
                    letterSpacing: 0.8,
                  ),
                ),
                const Text(
                  "Regulating the Engineering Profession",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      letterSpacing: 1,
                      height: 2),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset(
              Assets.logo,
              scale: 1.5,
              color: Color.fromARGB(180, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
