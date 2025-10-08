import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class ServiceReportScreen extends StatefulWidget {
  const ServiceReportScreen({super.key});

  @override
  State<ServiceReportScreen> createState() => _ServiceReportScreenState();
}

class _ServiceReportScreenState extends State<ServiceReportScreen> {
  final TextEditingController _summaryController = TextEditingController();

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.serviceReportTitle, context: context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(AppString.summaryOfWork)
                      .mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.blueField,
                      borderRadius: Measurement.generalSize12.allRadius,
                    ),
                    padding: Measurement.generalSize16.horizontalIsToVertical,
                    child: TextField(
                      controller: _summaryController,
                      maxLines: 6,
                      minLines: 6,
                      style: Measurement.mediumFont
                          .textStyle(AppColor.white, Measurement.font400),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppString.summaryPlaceholder,
                        hintStyle: Measurement.mediumFont
                            .textStyle(AppColor.grey, Measurement.font400),
                      ),
                    ),
                  ),
                  Measurement.generalSize24.height,
                  const Text(AppString.attachmentsLabel)
                      .mediumBold(AppColor.white),
                  Measurement.generalSize12.height,
                  _ActionTile(
                    icon: Icons.image_outlined,
                    title: AppString.addPhotosAttachments,
                    trailing: Icons.chevron_right,
                    onTap: () {},
                  ),
                  Measurement.generalSize24.height,
                  _ActionTile(
                    icon: Icons.draw_outlined,
                    title:
                        '${AppString.customerSignature} ${AppString.optionalLabel}',
                    trailing: Icons.chevron_right,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueStatusInner,
                  foregroundColor: AppColor.white,
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                ),
                onPressed: () {},
                child: const Text(AppString.submitReport)
                    .mediumBold(AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData trailing;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: Measurement.generalSize12.allRadius,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        padding: Measurement.generalSize16.allPadding,
        child: Row(
          children: [
            Container(
              width: Measurement.generalSize40,
              height: Measurement.generalSize40,
              decoration: BoxDecoration(
                color: AppColor.blueStatusOuter,
                borderRadius: Measurement.generalSize10.allRadius,
              ),
              child: Icon(icon, color: AppColor.white),
            ),
            Measurement.generalSize12.width,
            Expanded(child: Text(title).mediumBold(AppColor.white)),
            Icon(trailing, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}
