import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

AppBar getAppBar({required String title, required BuildContext context}) {
  return AppBar(
    backgroundColor: AppColor.background,
    elevation: Measurement.generalSize0,
    leading: Builder(
      builder: (ctx) => IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColor.white),
        onPressed: () => Navigator.pop(ctx),
      ),
    ),
    title: Text(title).largeBold(AppColor.white),
    centerTitle: true,
  );
}

PreferredSizeWidget getAppBarWithDrawer(
    {required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: AppColor.background,
    elevation: Measurement.generalSize0,
    leading: Builder(
      builder: (ctx) => IconButton(
        icon: const Icon(Icons.menu, color: AppColor.white),
        onPressed: () => Scaffold.of(ctx).openDrawer(),
      ),
    ),
    title: Text(title).largeBold(AppColor.white),
    centerTitle: true,
  );
}
