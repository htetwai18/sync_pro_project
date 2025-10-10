import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/screen/customer_room_assets_screen.dart';
import 'package:sync_pro/presentation/customer/screen/new_building_request_screen.dart';

class CustomerBuildingsScreen extends StatelessWidget {
  const CustomerBuildingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: "${AppString.addressLabel}es",
        context: context,
        canBack: false,
      ),
      body: Column(
        children: [
          // Buildings Section
          Expanded(
            child: SingleChildScrollView(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // // Buildings Header
                  // const Text(AppString.addressLabel)
                  //     .largeBold(AppColor.white),
                  // Measurement.generalSize16.height,

                  // Buildings List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mockBuildings.length,
                    separatorBuilder: (_, __) =>
                        Measurement.generalSize12.height,
                    itemBuilder: (context, index) {
                      final building = mockBuildings[index];
                      return _BuildingItem(
                        building: building,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CustomerRoomAssetsScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  Measurement.generalSize24.height,
                ],
              ),
            ),
          ),

          // Request New Building Button
          Container(
            padding: Measurement.generalSize16.allPadding,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewBuildingRequestScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueStatusInner,
                  foregroundColor: AppColor.white,
                  padding: Measurement.generalSize16.verticalPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  elevation: 0,
                ),
                child: const Text(AppString.requestNewBuilding)
                    .mediumBold(AppColor.white),
              ),
            ),
          ),
          Measurement.generalSize16.height,
        ],
      ),
    );
  }
}

class _BuildingItem extends StatelessWidget {
  final BuildingItemDisplayModel building;
  final VoidCallback? onTap;

  const _BuildingItem({
    required this.building,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Measurement.generalSize16.allPadding,
        decoration: BoxDecoration(
          color: AppColor.blueCard,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: Row(
          children: [
            // Building Icon
            Container(
              width: Measurement.generalSize48,
              height: Measurement.generalSize48,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize8.allRadius,
              ),
              child: const Icon(
                Icons.business,
                color: AppColor.white,
                size: Measurement.generalSize24,
              ),
            ),
            Measurement.generalSize16.width,

            // Building Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(building.name).mediumBold(AppColor.white),
                      ),
                      if (building.status != null) ...[
                        Measurement.generalSize8.width,
                        Container(
                          padding: Measurement.generalSize4.horizontalPadding +
                              Measurement.generalSize2.verticalPadding,
                          decoration: BoxDecoration(
                            color: AppColor.orangeStatusInner,
                            borderRadius: Measurement.generalSize12.allRadius,
                          ),
                          child: Text(building.status!)
                              .smallBold(AppColor.orangeStatusOuter),
                        ),
                      ],
                    ],
                  ),
                  Measurement.generalSize4.height,
                  Text(building.address).smallNormal(AppColor.grey),
                ],
              ),
            ),

            // Navigation Arrow
            const Icon(
              Icons.chevron_right,
              color: AppColor.grey,
              size: Measurement.generalSize20,
            ),
          ],
        ),
      ),
    );
  }
}
