import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/snack_bar/snack_bar.dart';
import 'package:medicinapp/features/pages/screens/medication/add_medication.dart';
import 'package:medicinapp/utils/constants/image_strings.dart';
import '../../../../common/custom_shape/widgets/medication_card/medication_card.dart';
import '../../../../common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/mediaQuery.dart';

class TodayMedicationSection extends StatelessWidget {
  const TodayMedicationSection({Key? key, required this.selectedDay})
      : super(key: key);
  final String selectedDay;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? _currentUser = _auth.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('app_user')
          .doc(_currentUser!.email)
          .collection('medications')
          .where('selectDays', arrayContains: selectedDay)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error message
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Align(
            alignment: Alignment.center,
            child: CustomContainer(
              width: MediaQueryUtils.getWidth(context) * .9,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        MediImages.m2,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: MediaQueryUtils.getWidth(context) * .02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('No appointments available for ${selectedDay}.'),
                          ElevatedButton(
                              onPressed: () {
                                Get.to(() => AddMedication());
                              },
                              child: Text('Add New Medication'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ); // Show message when data is empty
        }

        List<Widget> medicationRows = [];

        snapshot.data!.docs.forEach((DocumentSnapshot document) {
          final medData = document.data() as Map<String, dynamic>;
          final documentId = document.id;
          final medicineName = medData['medName'];
          final medDose = medData['medicineDose'];
          final medStrength = medData['medicineStrength'];
          final takeTime = medData['takeTime'];
          final medRemember = medData['rememberTime'];
          final inventoryAmount = medData['inventoryAmount'];
          final medID = medData['medId'];

          String medText;
          if (medID == 1) {
            medText = '$medDose ${medDose == 1 ? 'pill' : 'pills'} $takeTime';
          } else if (medID == 2) {
            medText =
                '$medDose ${medDose == 1 ? 'tablet' : 'tablets'} $takeTime';
          } else if (medID == 3) {
            medText = '$medDose ml $takeTime';
          } else if (medID == 4) {
            medText = 'Take $medDose $takeTime';
          } else {
            medText = '';
          }
          String medcategory;
          if (medID == 1) {
            medcategory = 'pills';
          } else if (medID == 2) {
            medcategory = 'tablets';
          } else if (medID == 3) {
            medcategory = 'mg';
          } else if (medID == 4) {
            medcategory = 'times';
          } else {
            medcategory = '';
          }
          String pillStrength;
          if (medID == 1 || medID == 2) {
            pillStrength = '$medStrength mg';
          } else if (medID == 3 || medID == 4) {
            pillStrength = '$medStrength ml';
          } else {
            pillStrength = medStrength;
          }

          medicationRows.add(
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MedicationCard(
                    medicineName: medicineName,
                    medText: medText + ' meals',
                    pillStrength: pillStrength,
                    image: medID == 1
                        ? MediImages.m1
                        : medID == 2
                            ? MediImages.m2
                            : medID == 3
                                ? MediImages.m3
                                : MediImages.img4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: TColors.textSecondary,
                            ),
                            Text(
                              'Reminders',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: TColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          medRemember,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: TColors.textSecondary,
                                  ),
                        ),
                        SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                if (inventoryAmount != 0) {
                                  int dose = medDose;
                                  int currentInventoryAmount =
                                      medData['inventoryAmount'];
                                  int newInventoryAmount =
                                      currentInventoryAmount - dose;

                                  FirebaseFirestore.instance
                                      .collection('app_user')
                                      .doc(_currentUser.email)
                                      .collection('medications')
                                      .doc(
                                          documentId) // Replace with your document ID
                                      .update({
                                    'inventoryAmount': newInventoryAmount
                                  }).then((_) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Medicine Taken'),
                                          content: Text(
                                              'Well done, you took your medicine.\nYou have onl $inventoryAmount' +
                                                  '$medcategory'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                // Get inventory amount from the backend and update it
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }).catchError((error) {
                                    SnackbarHelper.showSnackbar(
                                        title: 'Error',
                                        message: 'Can\'t take medicine',
                                        backgroundColor: Colors.red);
                                  });
                                } else {
                                  SnackbarHelper.showSnackbar(
                                      title: 'Error',
                                      message:
                                          'Your Medicine Ammount finish.Refill!',
                                      backgroundColor: Colors.red);
                                }
                              },
                              child: Text('Take'),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Your Medications Today',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: TColors.textSecondary,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQueryUtils.getHeight(context) * .02,
            ),
            Column(
              children: medicationRows,
            ),
          ],
        );
      },
    );
  }
}
