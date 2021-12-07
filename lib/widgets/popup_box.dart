import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

/// Requires Flushbar 1.10.24
class Popup {

  /// Optional title for the snack bar
  String? title;
  EdgeInsets? margin;
  double? borderRadius;
  double? titleSize;
  Color? textColor;
  double? textSize;
  Icon? icon;

  /// content to display
  final String message;
  final bool towerAbove;
  /// requires current build context
  final BuildContext context;
  final Color color;
  final Duration duration;
  /// controls the width of the snack bar with respect to the screen size.
  /// By default it's to 90% of the screen size as in 0.9
  /// The value must be in the range of (0.4 < [widthFactor] <= 1.0)
  final double widthFactor;

  Popup({
    required this.context,
    this.title,
    this.message = "I'm a default snack bar",
    this.color = Colors.black87,
    this.widthFactor = 0.9,
    this.towerAbove = false,
    this.textSize = 14,
    this.titleSize,
    this.textColor,
    this.icon,
    this.margin = const EdgeInsets.only(bottom: 22, top: 20),
    this.duration = const Duration(milliseconds: 1400),
    this.borderRadius = 8.0,
  }) : assert(
    widthFactor > 0.4 && widthFactor <= 1.0
  );

  Popup.standard({
    required this.context,
    this.title,
    this.message = "I'm a default snack bar",
    this.color = Colors.black87,
    this.widthFactor = 1.0,
    this.towerAbove = false,
    this.duration = const Duration(milliseconds: 1400),
  }): assert(
  widthFactor > 0.4 && widthFactor <= 1.0
  );

  /// don't want title? just pass null to title
  Popup.error({
    required this.context,
    this.title = 'Oops',
    this.message = "Something wrong happened",
    this.color = Colors.red,
    this.widthFactor = 0.9,
    this.towerAbove = false,
    this.textSize = 14,
    this.textColor,
    this.icon = const Icon(Icons.error_outline_outlined, color: Colors.white,),
    this.margin = const EdgeInsets.only(bottom: 22, top: 20),
    this.duration = const Duration(milliseconds: 1400),
    this.borderRadius = 8.0,
  }): assert(
  widthFactor > 0.4 && widthFactor <= 1.0
  );

  void show() {
    Size size = MediaQuery.of(context).size;
    // if(_flushBar != null) {
    //   // print('duplicate instance removing one');
    //   _flushBar?.dismiss();
    //   _flushBar = null;
    // }
    Flushbar(
      title: title,
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: textSize ?? 14,
          color: Colors.white
        ),
      ),
      duration: duration,
      backgroundColor: color,
      maxWidth: size.width * widthFactor,
      margin: margin ?? const EdgeInsets.all(0),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: towerAbove ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      icon: icon,
    ).show(context);
    // print(_flushBar);
    // await _flushBar?.show(context);
    // _flushBar = null;
  }

  // void showDefault() {
  //   ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 3),
  //       backgroundColor: color,
  //     )
  //   );
  // }
}
