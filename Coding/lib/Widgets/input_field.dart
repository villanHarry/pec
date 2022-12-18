import 'package:pec/Constants/Imports.dart';

class Input_field extends StatefulWidget {
  Input_field({
    Key? key,
    required this.text,
    this.obscure = false,
    this.isIcon = false,
    this.icon = const SizedBox(
      height: 0,
      width: 0,
    ),
  }) : super(key: key);

  final String text;
  final bool obscure;
  final bool isIcon;
  final Widget icon;
  TextEditingController myController = TextEditingController();

  @override
  State<Input_field> createState() => _Input_fieldState();
}

class _Input_fieldState extends State<Input_field> {
  bool prefix = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding:
            widget.isIcon ? null : const EdgeInsets.symmetric(horizontal: 18),
        height: height > 840 ? height / 16 : height / 14,
        width: width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(59, 158, 158, 158),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ]),
        child: TextFormField(
          controller: widget.myController,
          obscureText: widget.obscure ? prefix : false,
          obscuringCharacter: '*',
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: widget.isIcon ? widget.icon : null,
            suffixIconConstraints: BoxConstraints(maxWidth: width * 0.08),
            suffixIcon: Visibility(
              visible: widget.obscure,
              child: InkWell(
                onTap: () {
                  setState(() {
                    prefix = !prefix;
                  });
                },
                child: SizedBox(
                  width: width * 0.08,
                  child: prefix
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.hide_source,
                            color: Colors.grey,
                            size: width * 0.07,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.panorama_fish_eye_outlined,
                            color: Colors.grey,
                            size: width * 0.07,
                          ),
                        ),
                ),
              ),
            ),
            border: InputBorder.none,
            hintText: widget.text,
          ),
        ),
      ),
    );
  }
}
