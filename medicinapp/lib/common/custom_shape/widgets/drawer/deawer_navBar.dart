import 'package:flutter/material.dart';
import 'package:medicinapp/utils/lists/custom_lists.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/mediaQuery.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: TColors.appPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQueryUtils.getHeight(context) * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: MediaQueryUtils.getHeight(context) * 0.05),
          Expanded(
            child: ListView.builder(
              itemCount: CustomLists.drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(
                      CustomLists.drawerItems[index]['title'],
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onTap: () {
                      CustomLists.drawerItems[index]['onTap']();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
