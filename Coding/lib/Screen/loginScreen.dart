import 'package:pec/Screen/GreetingScreen.dart';
import 'package:pec/Services/API/Authentication.dart';

import '../Constants/Imports.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  bool loading = false;

  //Animation Controller
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(
        Alignment.center.x.toDouble(), Alignment.center.y.toDouble() + 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  //Animation Controller
  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: Offset(
        Alignment.center.x.toDouble(), Alignment.center.y.toDouble() + 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller2,
    curve: Curves.ease,
  ));

  @override
  void initState() {
    Timer(const Duration(milliseconds: 270), () {
      _controller.forward();
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Input_field email = Input_field(
    text: emailField,
  );
  Input_field pass = Input_field(
    text: "*******",
    obscure: true,
  );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFFFCFBFF),
        body: WillPopScope(
          onWillPop: () async {
            Screen.replace(context, const WelcomeScreen());
            return false;
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      const Spacer(),
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            color: const Color(0xFF091A31),
                            fontFamily: bold,
                            fontSize: 40,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w900),
                      ),
                      Text("Welcome to PEC Schedule Daily Meetings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF818182),
                              fontFamily: reg,
                              fontSize: 13,
                              height: 1,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: height > 840 ? width * 0.25 : width * 0.15,
                      ),
                      SlideTransition(position: _offsetAnimation, child: email),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SlideTransition(position: _offsetAnimation, child: pass),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: Button(
                          text: "SIGN IN",
                          press: () async {
                            if (email.myController.text.isNotEmpty &&
                                pass.myController.text.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              if (await AuthAPI.login(
                                  context,
                                  email.myController.text.toString(),
                                  pass.myController.text.toString())) {
                                setState(() {
                                  loading = false;
                                });
                                Screen.replace(context, const GreetingScreen());
                              } else {
                                setState(() {
                                  loading = false;
                                });
                              }
                            } else {
                              Screen.showSnackBar(
                                  context: context, content: "Fill all Fields");
                            }
                          },
                          bolds: true,
                          fontSize: 16,
                        ),
                      ),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: SignUpButton(() {
                          Screen.replace(context, const createAccount());
                        }),
                      ),
                      const Spacer(),
                      SlideTransition(
                        position: _offsetAnimation2,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(footer,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: thin,
                                  fontSize: 14.5,
                                )),
                            Text(" $footer2",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: reg,
                                  fontSize: 14.5,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height > 840 ? width * 0.05 : width * 0.05,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: loading,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: width,
                          height: height,
                          color: Color.fromARGB(128, 87, 100, 238),
                        ),
                        Shimmer.fromColors(
                          baseColor: const Color(0xFF5763EE),
                          direction: ShimmerDirection.ttb,
                          highlightColor:
                              const Color.fromARGB(128, 87, 100, 238),
                          enabled: loading,
                          child: Image.asset(
                            Assets.logo,
                            scale: 1.5,
                            color: white,
                          ),
                        ),
                        /*Image.asset(
                          Assets.logo,
                          scale: 1.5,
                          color: const Color.fromARGB(180, 255, 255, 255),
                        ),*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget SignUpButton(VoidCallback press, {Color color = Colors.transparent}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: InkWell(
          onTap: press,
          child: Container(
            height: MediaQuery.of(context).size.height / 11,
            width: 700,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Don't have an account?  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 52, 52, 52),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "SIGN UP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
