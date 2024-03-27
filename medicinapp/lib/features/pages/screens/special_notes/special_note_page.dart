import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/common/custom_shape/widgets/profileDetailField/profile_detail_field.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/features/pages/screens/special_notes/ad_note.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

class SpecialNotePage extends StatelessWidget {
  const SpecialNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String noData = 'No Data add Still';
    List<String> Labels = [
      'Vacsination Name',
      'Vacsination Date',
      'Vacsination Dose',
      'Alergies',
      'Prior Surgeries',
      'Prior Surgery Date'
    ];

    return CustomWidget(
        isShowback: true,
        title: 'Add Your Special Notes Here....',
        child: Column(
          children: [
            SizedBox(
              height: MediaQueryUtils.getHeight(context) * .05,
            ),
            CustomContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Special Note',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                          width: MediaQueryUtils.getWidth(context) * .3,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => AddSpecialNotePage());
                              },
                              child: Text('Add')))
                    ],
                  ),
                ),
                // details
                SizedBox(
                    height: MediaQueryUtils.getHeight(context) *
                        .65, // Set the height as needed
                    child: ListView.builder(
                        itemCount: Labels.length,
                        itemBuilder: (context, index) {
                          return DataDisplayCard(
                              labelText: Labels[index],
                              detailtext: noData,
                              onTapEdit: () {});
                        })),

                // details
              ],
            ))
          ],
        ));
  }
}
