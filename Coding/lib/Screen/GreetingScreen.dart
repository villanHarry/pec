import '../Constants/Imports.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );

  //Animation Controller
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(
        Alignment.center.x.toDouble(), Alignment.center.y.toDouble() + 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  var CurrentUser = Boxes.getUser().values.cast<User>().first;

  bool visible = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 270), () async {
      _controller.forward();
      Timer(const Duration(milliseconds: 270), () {
        setState(() {
          visible = true;
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFF),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Assets.diamond,
                    color: const Color(0xFFEEF0FD),
                    scale: 8.0,
                  ),
                  Image.asset(
                    Assets.userIcon,
                    scale: 18.0,
                  ),
                ],
              ),
              SizedBox(
                height: height > 840 ? width * 0.06 : width * 0.06,
              ),
              Text(
                "Hi, ${CurrentUser.fullname}",
                style: TextStyle(
                    color: const Color(0xFF091A31),
                    fontFamily: bold,
                    fontSize: 30,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: height > 840 ? width * 0.06 : width * 0.06,
              ),
              SizedBox(
                width: width * 0.85,
                child: Text(
                    "We've found that you already visited Smile and can automatically create your account using informaiton from your patient folder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF818182),
                        fontFamily: reg,
                        fontSize: height > 840 ? 16 : 15,
                        height: 1.5,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: height > 840 ? width * 0.06 : width * 0.06,
              ),
              SizedBox(
                height: height > 840 ? width * 0.06 : width * 0.06,
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: Button(
                  text: "OK, Let's Start!",
                  isUppercase: false,
                  press: () {
                    Screen.replace(context, const HomeScreen());
                  },
                  bolds: true,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: height > 840 ? width * 0.06 : width * 0.06,
              ),
              SlideTransition(
                position: _offsetAnimation,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: InkWell(
                      onTap: () {
                        var box = Boxes.getUser();
                        box.clear();
                        Screen.popallstack(context, const loginScreen());
                      },
                      child: Container(
                        height: height > 840 ? height / 16 : height / 14,
                        width: width,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFCFBFF),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "This is not me",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: Color(0xFF4C48EE),
                              ),
                            ),
                          ],
                        )),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
