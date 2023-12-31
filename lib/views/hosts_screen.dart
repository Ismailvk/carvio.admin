import 'package:admin_side/repositories/components/topbar_container.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:admin_side/views/pending_host.dart';
import 'package:admin_side/views/verified_host.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

class HostScreen extends StatelessWidget {
  const HostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopbarContainer(),
          Expanded(
            child: ContainedTabBarView(
              tabBarProperties: TabBarProperties(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.black,
                labelColor: AppColor.black,
                unselectedLabelColor: Colors.grey,
              ),
              tabs: const [
                Text('Pending Host'),
                Text('Verified Host'),
              ],
              views: [
                PendingHostScreen(),
                VerifiedHostScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
