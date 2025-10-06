import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';

class ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final int maxLines;

  const ReadOnlyField({
    super.key,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).smallBold(AppColor.grey),
        Measurement.generalSize8.height,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Measurement.generalSize16,
            vertical: Measurement.generalSize14,
          ),
          decoration: BoxDecoration(
            color: AppColor.blueField,
            borderRadius: Measurement.generalSize12.allRadius,
          ),
          child: Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ).mediumNormal(AppColor.white),
        ),
      ],
    );
  }
}
