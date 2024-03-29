import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart'; 
import 'package:medicinapp/common/custom_shape/widgets/medication_card/medication_card.dart'; 
import 'package:medicinapp/common/custom_shape/widgets/messages/info_massage/info_message.dart'; 
import 'package:medicinapp/utils/constants/colors.dart'; 

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/mediaQuery.dart';

class RefillSection extends StatelessWidget {
  const RefillSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth =
        FirebaseAuth.instance; // Initialize FirebaseAuth instance

    final User? _currentUser = _auth.currentUser; // Get current user
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance // Stream Firestore collection
          .collection('app_user')
          .doc(_currentUser!.email)
          .collection('medications')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Handle errors gracefully
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Show loading indicator
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('No Medications to fill'),
          ); // Show message when data is empty
        }
        List<Widget> medicationRows = [];

        snapshot.data!.docs.forEach((DocumentSnapshot document) {
          final medData = document.data()
              as Map<String, dynamic>; // Extract medication data
          final documentId = document.id; // Get document ID
          final medicineName = medData['medName']; // Extract medicine name
          final medDose = medData['medicineDose']; // Extract medicine dose
          final refillAmmount =
              medData['refillAmount']; // Extract refill amount
          final inventoryAmount =
              medData['inventoryAmount']; // Extract inventory amount
          final medID = medData['medId']; // Extract medicine ID
          int howManyDays =
              (inventoryAmount / (medDose ?? 1)).ceil(); // Calculate days
          if (inventoryAmount <= refillAmmount)
            medicationRows.add(
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MedicationCard(
                          medicineName: medicineName, // Set medicine name
                          medText:
                              'Only for $howManyDays days', // Set medication text
                          image: medID == 1
                              ? MediImages.m1
                              : medID == 2
                                  ? MediImages.m2
                                  : medID == 3
                                      ? MediImages.m3
                                      : MediImages.img4, // Set image
                          pillStrength: '', // Set pill strength
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () async {
                                String newValue = ""; // Initialize newValue
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: Border.all(style: BorderStyle.none),
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Fill Medication',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    content: TextField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: "Enter value",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        newValue = value; // Update newValue
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if (newValue.trim().isNotEmpty) {
                                            try {
                                              // Update Firestore document (assuming documentId is valid)
                                              await FirebaseFirestore.instance
                                                  .collection('app_user')
                                                  .doc(_currentUser.email)
                                                  .collection('medications')
                                                  .doc(documentId)
                                                  .update({
                                                'inventoryAmount':
                                                    int.tryParse(newValue) ?? 0,
                                              });

                                              // Success message (optional)
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Inventory amount updated successfully!'),
                                                ),
                                              );
                                            } on FirebaseException catch (e) {
                                              // Handle Firestore errors gracefully
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Error updating inventory: ${e.message}'),
                                                ),
                                              );
                                            } catch (e) {
                                              // Handle other unexpected errors
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'An error occurred: ${e.toString()}'),
                                                ),
                                              );
                                            }
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text('Refill'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        });
        if (medicationRows.isEmpty) {
          return SizedBox
              .shrink(); // Hide the entire section if there are no medications to refill
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Refill Your Medications',
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
            InfoMessage(text: 'Fill your Medications', onTap: () {}),
          ],
        );
      },
    );
  }
}
