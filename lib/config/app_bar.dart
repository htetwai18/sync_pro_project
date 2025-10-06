import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

AppBar getAppBar(
    {required String title, required IconData icon, required Function onTap}) {
  return AppBar(
    backgroundColor: AppColor.background,
    elevation: Measurement.generalSize0,
    leading: IconButton(
      icon: Icon(icon, color: AppColor.white),
      onPressed: () {
        onTap();
      },
    ),
    title: Text(title).largeBold(AppColor.white),
    centerTitle: true,
  );
}
