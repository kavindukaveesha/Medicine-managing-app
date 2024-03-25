import 'package:flutter/material.dart';
import 'package:medicinapp/common/custom_shape/widgets/appbar/custom_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        isShowback: false,
        title: 'Hello Kavindu! Welcome',
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  'I have register to firebase.now you can start develop your pages.After finishing comit and pull to test branch'),
            )
          ],
        ));
  }
}
