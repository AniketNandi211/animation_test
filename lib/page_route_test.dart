import 'package:flutter/material.dart';


// implementation of PageRouteBuilder
class PageRouteTest<T> extends PageRouteBuilder<T> {

  final Widget page;

  PageRouteTest({required this.page}) : super(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) => page,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) =>
            SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
              child: child,
            ),
            transitionDuration: const Duration(seconds: 2),
  );

}

// implementation of PageRoute
class FancyRoute<T> extends PageRoute<T> {

  final WidgetBuilder builder;
  RouteSettings? setting;

  FancyRoute({required this.builder, this.setting}) : super(
    settings: setting, fullscreenDialog: true
  );

  @override
  Color? get barrierColor => Colors.black87;

  @override
  String? get barrierLabel => 'Page opened';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(seconds: 1);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: builder(context),
    );
  }

}
