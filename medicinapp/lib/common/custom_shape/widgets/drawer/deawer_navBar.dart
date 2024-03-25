import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/mediaQuery.dart';


class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> drawerItems = [
      {'title': 'Home', 'onTap': () => print('Home tapped')},
      {'title': 'User Profile', 'onTap': () => print('User Profile tapped')},
      {
        'title': 'Add Medications',
        'onTap': () => print('Add Medications tapped')
      },
      {
        'title': 'Add Appointment',
        'onTap': () => print('Add Appointment tapped')
      },
      {'title': 'Medical Info', 'onTap': () => print('Medical Info tapped')},
      {'title': 'Special Notes', 'onTap': () => print('Special Notes tapped')},
      {'title': 'Logout', 'onTap': () => print('Logout tapped')},
    ];

    return Drawer(
      backgroundColor: TColors.appPrimaryColor,
      child: ListView.builder(
        itemCount: drawerItems.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQueryUtils.getHeight(context) * .05,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                  leading: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 40,
                    color: Colors.black,
                  ),
                )
              ],
            );
          }

          return Column(
            children: [
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .02,
              ),
              ListTile(
                title: Text(
                  drawerItems[index - 1]['title'],
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                onTap: () {
                  drawerItems[index - 1]['onTap']();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
