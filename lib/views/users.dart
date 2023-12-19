import 'package:admin_side/repositories/components/topbar_container.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:admin_side/views/unblocked_users.dart';
import 'package:admin_side/views/blocked_users.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  static const List<Tab> tabs = [
    Tab(text: 'UnBlocked Users'),
    Tab(text: 'Blocked Users'),
  ];

  static const List<Widget> views = [
    UnBlockedUsersScreen(),
    BlockedUsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopbarContainer(),
          Expanded(
            child: ContainedTabBarView(
              tabBarProperties: TabBarProperties(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.black,
                labelColor: AppColor.black,
                unselectedLabelColor: Colors.grey,
              ),
              tabs: tabs,
              views: views,
            ),
          ),
        ],
      ),
    );
  }
}
