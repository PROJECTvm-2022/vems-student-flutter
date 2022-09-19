import 'package:flutter/material.dart';
import 'package:vems/config/colors.dart';

class MyButton extends StatefulWidget {
  const MyButton(
      {@required this.child,
      Key key,
      this.onPressed,
      this.height,
      this.width,
      this.textStyle,
      this.cornerRadius = 6,
      this.color})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final double height, width;
  final Color color;
  final TextStyle textStyle;
  final double cornerRadius;

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Center(child: CircularProgressIndicator()),
          )
        : RaisedButton(
            onPressed: widget.onPressed,
            disabledTextColor: Color(0xff949494),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.cornerRadius)),
            padding: EdgeInsets.zero,
            textColor: Colors.white,
            child: Ink(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.cornerRadius)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.cornerRadius),
                    color: widget.onPressed != null
                        ? widget.color ?? MyColors.primaryBlue
                        : Color(0xffececec),
                  ),
                  constraints: BoxConstraints.tightFor(
                      width: widget.width ?? 350.0,
                      height: widget.height ?? 50.0),
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                      style: widget.textStyle == null
                          ? TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: widget.onPressed != null
                                  ? Colors.white
                                  : Color(0xff7c7c7c))
                          : widget.textStyle,
                      child: widget.child),
                )),
          );
  }
}
