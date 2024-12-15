import 'package:flutter/material.dart';

import '../../../../../utils/constants/mediaQuery.dart';

class InfoMessage extends StatelessWidget {
  const InfoMessage({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryUtils.getWidth(context) * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 243, 242, 242),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        '!',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                SizedBox(
                  width: MediaQueryUtils.getWidth(context) * .02,
                ),
                Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            IconButton(onPressed: onTap, icon: Icon(Icons.close_rounded)),
          ],
        ),
      ),
    );
  }
}
