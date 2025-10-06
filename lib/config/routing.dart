import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routing {
  static void transition(context, Widget screen, [Duration? duration]) {
    Future.delayed(duration ?? const Duration(milliseconds: 0), () async {
      await Navigator.push(context,
          PageTransition(child: screen, type: PageTransitionType.fade));
    });
  }

  static void bottomTopUp(context, Widget screen, [Duration? duration]) {
    Future.delayed(duration ?? const Duration(milliseconds: 0), () async {
      await Navigator.push(context,
          PageTransition(child: screen, type: PageTransitionType.bottomToTop));
    });
  }

  static void rightToLeftTransition(context, Widget screen,
      [Duration? duration]) {
    Future.delayed(duration ?? const Duration(milliseconds: 0), () async {
      await Navigator.push(context,
          PageTransition(child: screen, type: PageTransitionType.rightToLeft));
    });
  }

  static void replace(context, Widget screen, [Duration? duration]) {
    Future.delayed(duration ?? const Duration(milliseconds: 0), () async {
      Navigator.removeRoute(context,
          PageTransition(child: screen, type: PageTransitionType.fade));
    });
  }

  static void replacementTransition(context, Widget screen,
      [Duration? duration]) {
    Future.delayed(duration ?? const Duration(milliseconds: 0), () async {
      await Navigator.pushReplacement(
        context,
        PageTransition(child: screen, type: PageTransitionType.fade),
      );
    });
  }

}
