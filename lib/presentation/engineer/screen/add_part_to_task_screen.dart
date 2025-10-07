import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';

class AddPartToTaskScreen extends StatefulWidget {
  const AddPartToTaskScreen({super.key});

  @override
  State<AddPartToTaskScreen> createState() => _AddPartToTaskScreenState();
}

class _AddPartToTaskScreenState extends State<AddPartToTaskScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final List<int> _counts;

  @override
  void initState() {
    super.initState();
    _counts = List<int>.filled(mockParts.length, 0);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final filtered = mockParts
        .where((p) =>
            p.name.toLowerCase().contains(query) ||
            p.number.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.addPartToTask, context: context),
      body: Column(
        children: [
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: TextField(
                controller: _searchController,
                style: Measurement.mediumFont
                    .textStyle(AppColor.white, Measurement.font400),
                decoration: InputDecoration(
                  hintText: AppString.searchPartPlaceholder,
                  hintStyle: Measurement.mediumFont
                      .textStyle(AppColor.grey, Measurement.font400),
                  prefixIcon: const Icon(Icons.search, color: AppColor.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Measurement.generalSize16,
                    vertical: Measurement.generalSize14,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppString.inventory).mediumBold(AppColor.white),
                const Text(AppString.yourVan).smallNormal(AppColor.grey),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(

              padding: Measurement.generalSize16.horizontalIsToVertical,
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Measurement.generalSize12.height,
              itemBuilder: (context, index) {
                final part = filtered[index];
                final originalIndex = mockParts.indexOf(part);
                return Container(
                  decoration: BoxDecoration(
                    color: AppColor.blueField,
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(part.name).mediumBold(AppColor.white),
                            Measurement.generalSize8.height,
                            Text(part.number).smallNormal(AppColor.grey),
                            Measurement.generalSize4.height,
                            Text('${AppString.onHandLabel}: ${part.onHand}')
                                .smallNormal(AppColor.grey),
                          ],
                        ),
                      ),
                      _QtyButton(
                        icon: Icons.remove,
                        onPressed: () => setState(() {
                          if (_counts[originalIndex] > 0) {
                            _counts[originalIndex]--;
                          }
                        }),
                      ),
                      Measurement.generalSize12.width,
                      Text(_counts[originalIndex].toString())
                          .mediumBold(AppColor.white),
                      Measurement.generalSize12.width,
                      _QtyButton(
                        icon: Icons.add,
                        onPressed: () => setState(() {
                          _counts[originalIndex]++;
                        }),
                      ),
                    ],
                  ),
                );
              },
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
                child:
                    const Text(AppString.addToTask).mediumBold(AppColor.white),
              ),
            ),
          ),
          Measurement.generalSize12.height,
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _QtyButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.blueStatusOuter,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColor.blueStatusInner),
      ),
    );
  }
}
