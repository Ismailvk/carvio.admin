import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:admin_side/views/bookings.dart';
import 'package:admin_side/views/dashbord.dart';
import 'package:admin_side/views/hosts_screen.dart';
import 'package:admin_side/views/login_screen.dart';
import 'package:admin_side/views/profile.dart';
import 'package:admin_side/views/vehicle.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> pages = [
    const DashBoardScreen(),
    VehicleScreen(),
    const UsersScreen(),
    const BookingScreen(),
    const HostScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/logoBlack.png'),
                  const SizedBox(height: 20),
                  buildListTile(0, Icons.dashboard, 'Dashboard'),
                  buildListTile(1, Icons.directions_car, 'Vehicle'),
                  buildListTile(2, Icons.account_circle, 'Users'),
                  buildListTile(3, Icons.view_list, 'Booking'),
                  buildListTile(4, Icons.diversity_3, 'Hosts'),
                  buildListTile(5, Icons.logout, 'Logout')
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: AppColor.white,
              child: pages[index],
            ),
          )
        ],
      ),
    );
  }

  Widget buildListTile(int tabIndex, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon,
          color: index == tabIndex ? AppColor.black : AppColor.appbarGrey),
      title: Text(
        title,
        style: TextStyle(
            color: index == tabIndex ? AppColor.black : AppColor.appbarGrey),
      ),
      onTap: () {
        if (tabIndex == 5) {
          dialogBuilder(context);
        } else {
          changePage(tabIndex);
        }
      },
    );
  }

  void changePage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  // Log out section
  dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want logout your account'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Logout'),
              onPressed: () async {
                await Sharedpref.instance.removeToken();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
