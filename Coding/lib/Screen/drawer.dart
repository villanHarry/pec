import '/Constants/Imports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(
      {Key? key,
      required this.child,
      required this.advancedDrawerController,
      required this.user})
      : super(key: key);
  final AdvancedDrawerController advancedDrawerController;
  final Widget child;
  final User user;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AdvancedDrawer(
      backdropColor: const Color(0xFF4C48EE),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openRatio: 0.75,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      drawer: builddrawer(context),
      child: child,
    );
  }

  Widget builddrawer(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width / 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.5),
          child: InkWell(
            onTap: () {
              advancedDrawerController.hideDrawer();
            },
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.5),
          child: CachedNetworkImage(
            imageUrl: user.image,
            imageBuilder: (context, imageProvider) => Container(
              height: width * 0.3,
              width: width * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: white, width: 2.5),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, url, progress) => Container(
              height: width * 0.3,
              width: width * 0.3,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: CircularProgressIndicator(
                value: progress.progress,
                strokeWidth: 2.5,
                color: white,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.5),
          child: Text(
            user.fullname,
            style: TextStyle(
                color: white,
                fontFamily: bold,
                fontSize: height > 840 ? 40 : 35,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.5),
          child: Divider(
            color: white,
            thickness: 2.5,
          ),
        ),

        //Logout Button
        navigaitonTile(
          onpress: () {
            final box2 = Boxes.getUser();

            box2.clear();

            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const loginScreen()));
          },
          last: true,
          icon: const Icon(
            Icons.power_settings_new_rounded,
            color: Colors.white,
          ),
          text: "Logout",
        ),
        const Spacer(),
      ],
    );
  }
}

class navigaitonTile extends StatelessWidget {
  const navigaitonTile(
      {Key? key,
      required this.text,
      required this.onpress,
      this.icon = const SizedBox(width: 0, height: 0),
      this.last = false})
      : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onpress;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.5),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(
                  bottom: BorderSide(width: 0.2, color: Colors.white)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(
              "  $text",
              style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
