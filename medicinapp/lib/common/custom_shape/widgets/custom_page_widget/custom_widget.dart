import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/drawer/deawer_navBar.dart';

class CustomWidget extends StatelessWidget {
  final bool isShowback;
  final String title;
  final Widget child;

  const CustomWidget(
      {super.key,
      required this.isShowback,
      required this.title,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
