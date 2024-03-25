import 'package:flutter/material.dart';
import 'package:medicinapp/common/custom_shape/widgets/appbar/custom_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        isShowback: false, title: 'Hello Kavindu! Welcome', child: Column());
  }
}
