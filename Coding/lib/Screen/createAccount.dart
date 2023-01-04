import '../Constants/Imports.dart';

class createAccount extends StatefulWidget {
  const createAccount({Key? key}) : super(key: key);

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final AnimationController _controller3 = AnimationController(
    duration: const Duration(seconds: 3),
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

  bool visible = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 270), () async {
      _controller.forward();
      Timer(const Duration(milliseconds: 270), () {
        setState(() {
          visible = true;
        });
        _controller2.forward();
        _controller3.forward();
      });
    });
    // TODO: implement initState
    super.initState();
  }

  bool icon = false;

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  File file = File("");
  void addImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spacer(),
            Text("Select Source"),
            Spacer(),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context, ImageSource.camera),
              child: const Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context, ImageSource.gallery),
              child: const Icon(
                Icons.image,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ).then((ImageSource? value) async {
      if (value != null) {
        File filetemp = await ImageUpload.getImage(value);
        if (filetemp.path.isNotEmpty) {
          setState(() {
            file = filetemp;
          });
        }
      }
    });
  }

  Input_field fullname = Input_field(
    text: "Full Name",
  );
  Input_field email = Input_field(
    text: "Email",
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
            Screen.replace(context, const loginScreen());
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
                      Spacer(
                        flex: height > 840 ? 3 : 8,
                      ),
                      Text(
                        "SIGNUP",
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
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: width * 0.35,
                            height: width * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF6587F2),
                                  Color(0xFF4C48EE),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (file.path.isNotEmpty) {
                                addImage();
                              }
                            },
                            child: Container(
                              width: width * 0.325,
                              height: width * 0.325,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFCFBFF),
                                  image: file.path.isNotEmpty
                                      ? DecorationImage(
                                          image: FileImage(file),
                                          fit: BoxFit.cover)
                                      : null,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SlideTransition(
                          position: _offsetAnimation, child: fullname),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SlideTransition(position: _offsetAnimation, child: email),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SlideTransition(position: _offsetAnimation, child: pass),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      AnimatedOpacity(
                        opacity: visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 900),
                        child: Center(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              icon = !icon;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank,
                                color: const Color(0xFF4C48EE),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              const Text(
                                "KEEP SAVE FOR THE NEXT TIME",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 50, 50, 50),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      SizedBox(
                        height: height > 840 ? width * 0.06 : width * 0.06,
                      ),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: Button(
                          text: "SIGN UP",
                          press: () async {
                            if (email.myController.text.isNotEmpty &&
                                pass.myController.text.isNotEmpty &&
                                fullname.myController.text.isNotEmpty &&
                                file.path.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              if (await AuthAPI.signUp(
                                  context,
                                  email.myController.text.toString(),
                                  pass.myController.text.toString(),
                                  fullname.myController.text.toString(),
                                  await ImageUpload.generate(context, file))) {
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

                            //Screen.replace(context, const GreetingScreen());
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
                        child: Button(
                          isUppercase: false,
                          text: "Connect with Facebook",
                          press: () {
                            Screen.replace(context, const GreetingScreen());
                          },
                          bolds: true,
                          fontSize: 16,
                        ),
                      ),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: SignUpButton(() {
                          Screen.replace(context, const loginScreen());
                        }),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Visibility(
                    visible: file.path.isEmpty,
                    child: Positioned(
                      top: height > 840 ? width * 0.38 : width * 0.28,
                      child: InkWell(
                        onTap: () {
                          addImage();
                        },
                        child: Lottie.asset(
                          Assets.animatedCamera,
                          height: width * 0.5,
                          fit: BoxFit.cover,
                          frameRate: FrameRate(60),
                          controller: _controller3,
                        ),
                      ),
                    ),
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
                  "Have an account?  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 52, 52, 52),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "SIGN IN",
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
