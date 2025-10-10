import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/screen/customer_dashboard_screen.dart';
import 'package:sync_pro/presentation/customer/screen/customer_profile_screen.dart';
import 'package:sync_pro/presentation/customer/screen/customer_buildings_screen.dart';
import 'package:sync_pro/presentation/customer/screen/customer_service_list_screen.dart';
import 'package:sync_pro/presentation/customer/screen/invoices_customer_screen.dart';

class BottomNavigationCustomer extends StatefulWidget {
  const BottomNavigationCustomer({
    super.key,
  });

  @override
  State<BottomNavigationCustomer> createState() =>
      _BottomNavigationCustomerState();
}

class _BottomNavigationCustomerState extends State<BottomNavigationCustomer> {
  int currentIndex = 0;
  List<Widget> mobileScreens = [];

  @override
  void initState() {
    super.initState();
    mobileScreens = [
      const CustomerDashboardScreen(),
      const CustomerBuildingsScreen(),
      const CustomerServiceListScreen(),
      const CustomerProfileScreen(),
      const InvoicesCustomerScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Measurement.generalSize10),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.background,
          body: IndexedStack(
            index: currentIndex,
            children: mobileScreens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            backgroundColor: AppColor.background,
            selectedItemColor: AppColor.white,
            unselectedItemColor: AppColor.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: AppString.dashboard,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: "${AppString.addressLabel}es",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: AppString.serviceRequests,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: AppString.profile,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: AppString.invoice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
