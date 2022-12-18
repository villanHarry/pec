import '../Constants/Imports.dart';

class Button extends StatelessWidget {
  Button(
      {Key? key,
      required this.text,
      required this.press,
      this.bolds = false,
      this.isIcon = false,
      this.icon = const SizedBox(
        height: 0,
        width: 0,
      ),
      this.fontSize = 14.5,
      this.lessPadding = false,
      this.isUppercase = true,
      this.textColor = Colors.white})
      : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback press;
  final bool isUppercase;
  final bool isIcon;
  final bool bolds;
  final Widget icon;
  final double fontSize;
  final bool lessPadding;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: lessPadding
            ? const EdgeInsets.symmetric(horizontal: 22.5)
            : const EdgeInsets.symmetric(horizontal: 40),
        child: InkWell(
          onTap: press,
          child: Container(
            height: height > 840 ? height / 16 : height / 14,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6587F2),
                  Color(0xFF4C48EE),
                ],
              ),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(visible: isIcon, child: icon),
                Text(
                  isIcon
                      ? "   ${isUppercase ? text.toUpperCase() : text}"
                      : isUppercase
                          ? text.toUpperCase()
                          : text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: bolds ? bold : reg,
                    fontSize: fontSize,
                    letterSpacing: 0.5,
                    color: textColor,
                    fontWeight: bolds ? FontWeight.w800 : FontWeight.normal,
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
