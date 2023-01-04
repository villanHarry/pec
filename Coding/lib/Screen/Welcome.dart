import '../Constants/Imports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );

  //Animation Controller
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(
        Alignment.center.x.toDouble(), Alignment.center.y.toDouble() + 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  late Timer _timer;
  int _start = 0;
  bool backpress = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 270), () {
      _controller.forward();
    });
    // TODO: implement initState
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            backpress = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: Button(
              text: "Let's Start",
              press: () {
                Screen.replace(context, const loginScreen());
              },
              bolds: true,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: width * 0.12,
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (!backpress) {
            Screen.showSnackBar(
                context: context, content: "Press Again to exit");
            setState(() {
              backpress = true;
              _start = 1;
            });
            startTimer();
          } else {
            return true;
          }
          return false;
        },
        child: Column(
          children: [
            Container(
              width: width,
              height: height > 840 ? width * 0.95 : width * 0.75,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.pec),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomRight)),
            ),
            SizedBox(
              height: width * 0.15,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                  color: const Color(0xFF091A31),
                  fontFamily: bold,
                  fontSize: height > 840 ? 45 : 40,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              width: width * 0.9,
              child: Text(
                "The Pakistan Engineering Council is a statutory body, constituted under the PEC Act 1976 (V of 1976) amended upto 24th January 2011, to regulate the engineering profession in the country such that it shall function as key driving force for achieving rapid and sustainable growth in all national, economic and social fields.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF818182),
                    fontSize: height > 840 ? 16 : 15,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 1,
                    height: 1.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
