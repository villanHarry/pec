import '../Constants/Imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(
        Alignment.center.x.toDouble(), Alignment.center.y.toDouble() - 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: Offset(
        Alignment.center.x.toDouble(), Alignment.center.y.toDouble() + 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  var CurrentUser = Boxes.getUser().values.cast<User>().first;
  bool past = true;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    Timer(const Duration(milliseconds: 270), () {
      _controller.forward();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFF),
      appBar: appbar(),
      /*bottomNavigationBar: bottomBar(width),*/
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              past ? "Past Meetings" : "Upcoming Meetings",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
                fontFamily: bold,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF9393A0),
              ),
            ),
            SizedBox(
              height: width * .08,
            ),
            Row(
              children: [
                Text(
                  "Meetings",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontFamily: bold,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF9393A0),
                  ),
                ),
                const Spacer(),
                Text(
                  "See All Meetings",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontFamily: reg,
                    color: const Color.fromARGB(255, 0, 64, 255),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width * .06,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const MeetingNode();
              },
            ))
          ],
        ),
      ),
    );
  }

  SlideTransition bottomBar(double width) {
    var height = MediaQuery.of(context).size.height;
    return SlideTransition(
      position: _offsetAnimation2,
      child: Container(
        height: height > 840 ? width * 0.25 : width * 0.2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  navIcon(
                    icon: Icons.home_outlined,
                    selected: true,
                  ),
                  navIcon(
                    icon: Icons.missed_video_call_outlined,
                  ),
                  navIcon(
                    icon: Icons.image_outlined,
                  ),
                  navIcon(
                    icon: Icons.account_circle_outlined,
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize appbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, height > 840 ? width * 0.55 : width * 0.6),
      child: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.5),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height > 840 ? width * .1 : width * .07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: CurrentUser.image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: width * 0.16,
                                width: width * 0.16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Container(
                                height: width * 0.16,
                                width: width * 0.16,
                                decoration: const BoxDecoration(
                                    color: Color(0xFF4C48EE),
                                    shape: BoxShape.circle),
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                  strokeWidth: 2.5,
                                  color: white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFFCFBFF),
                                      width: 4.0),
                                  shape: BoxShape.circle),
                              child: Container(
                                height: width * 0.025,
                                width: width * 0.025,
                                decoration: const BoxDecoration(
                                    color: const Color(0xFF4C48EE),
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Meetings",
                    style: TextStyle(
                        color: const Color(0xFF091A31),
                        fontFamily: bold,
                        fontSize: 35,
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
                ],
              ),
              SizedBox(
                height: width * .09,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            past = true;
                          });
                        },
                        child: Container(
                          height: height > 840 ? height / 19 : height / 14,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              color: past
                                  ? const Color(0xFFFCFBFF)
                                  : const Color(0xFFEEEFF4),
                              boxShadow: past
                                  ? [
                                      const BoxShadow(
                                          color:
                                              Color.fromARGB(59, 158, 158, 158),
                                          blurRadius: 3,
                                          offset: Offset(0, 2))
                                    ]
                                  : null),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "PAST",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontFamily: bold,
                                  fontWeight: FontWeight.w900,
                                  color: past
                                      ? const Color(0xFF4C48EE)
                                      : const Color(0xFF9393A0),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            past = false;
                          });
                        },
                        child: Container(
                          height: height > 840 ? height / 19 : height / 14,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: past
                                  ? const Color(0xFFEEEFF4)
                                  : const Color(0xFFFCFBFF),
                              boxShadow: past
                                  ? null
                                  : [
                                      const BoxShadow(
                                          color:
                                              Color.fromARGB(59, 158, 158, 158),
                                          blurRadius: 3,
                                          offset: Offset(0, 2))
                                    ]),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Upcoming",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontFamily: bold,
                                  fontWeight: FontWeight.w900,
                                  color: past
                                      ? const Color(0xFF9393A0)
                                      : const Color(0xFF4C48EE),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class navIcon extends StatefulWidget {
  navIcon({
    Key? key,
    this.selected = false,
    required this.icon,
  }) : super(key: key);
  bool selected;
  final IconData icon;
  @override
  State<navIcon> createState() => _navIconState();
}

class _navIconState extends State<navIcon> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        setState(() {
          widget.selected = !widget.selected;
        });
      },
      child: Column(
        children: [
          Icon(
            widget.icon,
            color: widget.selected ? blue2 : Colors.grey,
            size: width * 0.1,
          ),
          Visibility(
              visible: widget.selected,
              child: CircleAvatar(
                backgroundColor: blue2,
                radius: width * 0.01,
              ))
        ],
      ),
    );
  }
}

class MeetingNode extends StatefulWidget {
  const MeetingNode({Key? key}) : super(key: key);

  @override
  State<MeetingNode> createState() => _MeetingNodeState();
}

class _MeetingNodeState extends State<MeetingNode> {
  bool icon = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 192, 192, 209),
            )),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "IT Committee Meeting",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22.5,
                    fontFamily: bold,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF091A31),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: icon,
                  child: InkWell(
                    onTap: () => setState(() {
                      icon = !icon;
                    }),
                    child: Icon(
                      icon
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      size: width * .07,
                      color: const Color(0xFF9393A0),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: !icon,
              child: Row(
                children: [
                  const Text(
                    "Karachi",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.5,
                      color: const Color(0xFF091A31),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "8:00 PM | ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: bold,
                      letterSpacing: 0.5,
                      color: const Color(0xFF091A31),
                    ),
                  ),
                  const Text(
                    "Duration: ${120} min",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.5,
                      color: Color(0xFF091A31),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      icon = !icon;
                    }),
                    child: Icon(
                      icon
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      size: width * .07,
                      color: const Color(0xFF9393A0),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: icon,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${120} min",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.5,
                      fontFamily: bold,
                      color: const Color(0xFF9393A0),
                    ),
                  ),
                  SizedBox(
                    height: width * .06,
                  ),
                  const Text(
                    "Location: Saddar Karachi",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF9393A0),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Meeting Duration: ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9393A0),
                        ),
                      ),
                      Text(
                        "8:00 PM to 10:00 PM",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: bold,
                          letterSpacing: 0.5,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9393A0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "PARTICIPATION: ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9393A0),
                        ),
                      ),
                      Text(
                        "20",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: bold,
                          letterSpacing: 0.5,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9393A0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
