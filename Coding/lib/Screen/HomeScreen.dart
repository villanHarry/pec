import 'package:intl/intl.dart';
import '../Constants/Imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final advancedDrawerController = AdvancedDrawerController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );

  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 300),
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

  late final Animation<Offset> _offsetAnimation3 = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(
        Alignment.center.x.toDouble() - 1, Alignment.center.y.toDouble()),
  ).animate(CurvedAnimation(
    parent: _controller2,
    curve: Curves.ease,
  ));
  DateTime currentDate = DateTime.now();
  int firstDay = 1;
  int lastDay = 0;

  var CurrentUser = Boxes.getUser().values.cast<User>().first;
  bool past = true;
  bool showCalender = false;

  late Timer _timer;
  int _start = 0;
  bool backpress = false;

  bool loading = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    _controller2.forward();
    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showCalender = false;
        });
      }
      if (status == AnimationStatus.reverse) {
        setState(() {
          showCalender = true;
        });
      }
    });
    Timer(const Duration(milliseconds: 270), () {
      _controller.forward();
    });
    DateSetting();

    // TODO: implement initState
    super.initState();
  }

  DateSetting() {
    for (int i = 1; i <= 7; i++) {
      if (currentDate.subtract(Duration(days: i)).weekday == 1) {
        setState(() {
          firstDay = i;
        });
      }
      if (currentDate.add(Duration(days: i)).weekday == 7) {
        setState(() {
          lastDay = i;
        });
      }
    }
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
    _controller2.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return CustomDrawer(
      user: CurrentUser,
      advancedDrawerController: advancedDrawerController,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFFCFBFF),
            appBar: appbar(),
            /*floatingActionButton: CurrentUser.userType == "master"
                ? FloatingActionButton(
                    onPressed: () {
                      Screen.push(context, const MeetingFormScreen());
                    },
                    backgroundColor: const Color.fromARGB(255, 0, 64, 255),
                    child: Icon(Icons.add, color: white),
                  )
                : null,*/
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
              child: Padding(
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
                    SlideTransition(
                        position: _offsetAnimation3,
                        child: AnimatedOpacity(
                            opacity: showCalender ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Visibility(
                              visible: showCalender,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: width * .08),
                                child: TableCalendar(
                                  focusedDay: currentDate,
                                  currentDay: currentDate,
                                  firstDay: currentDate
                                      .subtract(Duration(days: firstDay)),
                                  lastDay:
                                      currentDate.add(Duration(days: lastDay)),
                                  calendarFormat: CalendarFormat.week,
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  headerVisible: false,
                                  rowHeight: 60,
                                  daysOfWeekHeight: 25,
                                  onDaySelected: (select, notSelected) {
                                    setState(() {
                                      currentDate = select;
                                    });
                                    DateSetting();
                                  },
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                    dowTextFormatter: (date, locale) =>
                                        DateFormat.E(locale)
                                            .format(date)
                                            .toUpperCase(),
                                  ),
                                  calendarStyle: CalendarStyle(
                                    todayDecoration: const BoxDecoration(
                                        color: Color(0xFF546DF6),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    defaultDecoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    weekendDecoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                            ))),
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
                        return MeetingNode(
                          onpress: () async {
                            setState(() {
                              loading = true;
                            });
                            if (await MeetingAPI.MeetingId(context)) {
                              setState(() {
                                loading = false;
                              });
                              Screen.push(context, const VideoCall());
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        );
                      },
                    ))
                  ],
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
                  highlightColor: const Color.fromARGB(128, 87, 100, 238),
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
    );
  }

  PreferredSize appbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, height > 840 ? width * 0.4 : width * 0.45),
      child: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.5),
          child: Column(
            children: [
              SizedBox(
                height: height > 840 ? width * .12 : width * .07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                  const Spacer(),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: CurrentUser.image,
                          imageBuilder: (context, imageProvider) => Container(
                            height: width * 0.16,
                            width: width * 0.16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, progress) =>
                              Container(
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
                                  color: const Color(0xFFFCFBFF), width: 4.0),
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
              SizedBox(
                height: width * .07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (!past) {
                            await _controller2.forward();
                          }
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
                        onTap: () async {
                          await _controller2.reverse();
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
  const MeetingNode({Key? key, required this.onpress}) : super(key: key);

  final VoidCallback onpress;

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: widget.onpress,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 30.0),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF6587F2),
                                    Color(0xFF4C48EE),
                                  ],
                                ),
                              ),
                              child: const Text(
                                "Attend",
                                style: TextStyle(color: Colors.white),
                              ),
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
          Positioned(
            top: width * -0.02,
            right: width * 0.001,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width * 0.09,
                  height: width * 0.09,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFCFBFF),
                  ),
                ),
                SizedBox(
                  width: width * 0.05,
                  height: width * 0.05,
                  child: const Icon(
                    Icons.check_circle,
                    color: Color.fromARGB(255, 0, 64, 255),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
