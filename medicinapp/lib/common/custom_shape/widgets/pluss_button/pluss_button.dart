import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/mediaQuery.dart';

class PlussButton extends StatelessWidget {
  const PlussButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQueryUtils.getWidth(context) * .1,
        height: MediaQueryUtils.getWidth(context) * .1,
        decoration: BoxDecoration(
          color: TColors.appPrimaryColor,
          borderRadius: BorderRadius.circular(
            MediaQueryUtils.getWidth(context) * .1,
          ),
        ),
        child: Center(
          child: Text(
            '+',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
