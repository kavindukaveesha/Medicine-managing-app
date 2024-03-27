import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicinapp/common/custom_shape/widgets/dropdowns/dayPicker_dropdown.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/utils/constants/colors.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

import '../../../common/custom_shape/widgets/custom_page_widget/custom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWidget(
        isShowback: false,
        title: 'Hello Kavindu',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DayPickerDropdown(
                listName: days,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Your Next Appointment',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: TColors.textSecondary), // Adjusted to headline6
                ),
              ),
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .05,
              ),
              // crearte appointment card
              Align(
                alignment: Alignment.center,
                child: CustomContainer(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dr Nikalos',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: TColors.textSecondary,
                                      fontSize: 20),
                            ),
                            Container(
                              width: MediaQueryUtils.getWidth(context) * .1,
                              height: MediaQueryUtils.getWidth(context) * .1,
                              decoration: BoxDecoration(
                                  color: TColors.appPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                    MediaQueryUtils.getWidth(context) * .1,
                                  )),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Day',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      '03/02/2024',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: TColors.textSecondary),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Time',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      '2.30 pm',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: TColors.textSecondary),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Number',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      '40',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: TColors.textSecondary),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQueryUtils.getHeight(context) * .02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Nawaloka hospital,Colombo',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: TColors.textSecondary),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQueryUtils.getHeight(context) * .02,
                      )
                    ],
                  ),
                )),
              )

              // create  medicines to tske
              ,
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'Your Next Appointment',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: TColors.textSecondary), // Adjusted to headline6
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
