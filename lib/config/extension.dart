import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sync_pro/config/measurement.dart';

extension NullableStringExtension on String? {
  bool isNotEmptyOrNot() {
    return this != null && (this?.isNotEmpty ?? false) && this != "";
  }
}

extension TextStyleExtension on double {
  TextStyle textStyle(Color? color, FontWeight? fontWeight) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: fontWeight,
      fontSize: this,
    );
  }
}

extension TextExtension on Text {
  Text smallNormal(Color color) {
    return Text(
      data ?? '',
      style: Measurement.smallFont.textStyle(color, Measurement.font400),
    );
  }

  Text smallBold(Color color) {
    return Text(
      data ?? '',
      style: Measurement.smallFont.textStyle(color, Measurement.font600),
    );
  }

  Text mediumNormal(Color color) {
    return Text(
      data ?? '',
      style: Measurement.mediumFont.textStyle(color, Measurement.font400),
    );
  }

  Text mediumBold(Color color) {
    return Text(
      data ?? '',
      style: Measurement.mediumFont.textStyle(color, Measurement.font600),
    );
  }

  Text largeNormal(Color color) {
    return Text(
      data ?? '',
      style: Measurement.largeFont.textStyle(color, Measurement.font400),
    );
  }

  Text largeBold(Color color) {
    return Text(
      data ?? '',
      style: Measurement.largeFont.textStyle(color, Measurement.font600),
    );
  }

  Text xLargeNormal(Color color) {
    return Text(
      data ?? '',
      style: Measurement.xLargeFont.textStyle(color, Measurement.font400),
    );
  }

  Text xLargeBold(Color color) {
    return Text(
      data ?? '',
      style: Measurement.xLargeFont.textStyle(color, Measurement.font600),
    );
  }
}

extension SizedExtension on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );

  SizedBox get width => SizedBox(
        width: toDouble(),
      );

  num widthRatio(BuildContext context) =>
      MediaQuery.sizeOf(context).width * this;

//padding
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());

  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());

  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());

  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());

  EdgeInsets get horizontalIsToVertical =>
      EdgeInsets.symmetric(horizontal: toDouble(), vertical: toDouble() / 2);

  ///border radius
  BorderRadius get allRadius => BorderRadius.circular(toDouble());
}
