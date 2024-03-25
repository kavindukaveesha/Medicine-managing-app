import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/drawer/deawer_navBar.dart';

class CustomAppBar extends StatelessWidget {
  final bool isShowback;
  final String title;

  const CustomAppBar(
      {super.key, required this.isShowback, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: NavBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: isShowback
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                    ))
                : null,
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        
        
        );
  }
}
