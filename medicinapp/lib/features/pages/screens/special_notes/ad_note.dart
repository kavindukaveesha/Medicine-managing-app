import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/common/custom_shape/widgets/snack_bar/snack_bar.dart';
import 'package:medicinapp/common/custom_shape/widgets/text_inputs/text_input_field.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';
import 'package:medicinapp/utils/lists/custom_lists.dart';

class AddSpecialNotePage extends StatefulWidget {
  const AddSpecialNotePage({Key? key});

  @override
  State<AddSpecialNotePage> createState() => _AddSpecialNotePageState();
}

class _AddSpecialNotePageState extends State<AddSpecialNotePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  final TextEditingController vaccinationNameController =
      TextEditingController();
  final TextEditingController vaccinationDateController =
      TextEditingController();
  final TextEditingController vaccinationDoseController =
      TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController priorSurgeriesController =
      TextEditingController();
  final TextEditingController priorSurgeryDateController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      setState(() {
        _currentUser = currentUser;
      });
      print(_currentUser!.email);
    } else {
      // Handle the scenario where currentUser is null
    }
  }

  @override
  void dispose() {
    vaccinationNameController.dispose();
    vaccinationDateController.dispose();
    vaccinationDoseController.dispose();
    allergiesController.dispose();
    priorSurgeriesController.dispose();
    priorSurgeryDateController.dispose();
    super.dispose();
  }

  Future<void> _saveDataToFirestore() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('app_user');

    // Reference the current user's document
    DocumentReference userDocRef = users.doc(_currentUser!.email);

    // Add a new note document to the 'special_notes' subcollection
    userDocRef.collection('special_notes').add({
      'Vaccination Name': vaccinationNameController.text.trim(),
      'Vaccination Date': vaccinationDateController.text.trim(),
      'Vaccination Dose': vaccinationDoseController.text.trim(),
      'Allergies': allergiesController.text.trim(),
      'Prior Surgeries': priorSurgeriesController.text.trim(),
      'Prior Surgery Date': priorSurgeryDateController.text.trim()
    }).then((value) {
      // Show success snackbar
      SnackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Successfully added note!',
      );
    }).catchError((error) {
      // Show error snackbar
      SnackbarHelper.showSnackbar(
        title: 'Error',
        message: 'Failed to add note: $error',
        backgroundColor: Colors.red,
      );
    });
    // Clearing values after submitting the form
    Future.delayed(const Duration(seconds: 2), () {
      vaccinationNameController.clear();
      vaccinationDateController.clear();
      vaccinationDoseController.clear();
      allergiesController.clear();
      priorSurgeriesController.clear();
      priorSurgeryDateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      isShowback: true,
      title: 'Add Your Special Notes Here....',
      child: Column(
        children: [
          SizedBox(
            height: MediaQueryUtils.getHeight(context) * .05,
          ),
          Align(
            alignment: Alignment.center,
            child: CustomContainer(
              width: MediaQueryUtils.getWidth(context) * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' Add Special Note',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  // Details

                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        InputField(
                          prefixIcon: Icons.health_and_safety,
                          labelText: CustomLists.noteLabels[0],
                          controller: vaccinationNameController,
                        ),
                        InputField(
                          prefixIcon: Icons.date_range,
                          labelText: CustomLists.noteLabels[1],
                          controller: vaccinationDateController,
                        ),
                        InputField(
                          prefixIcon: Icons.local_pharmacy,
                          labelText: CustomLists.noteLabels[2],
                          controller: vaccinationDoseController,
                        ),
                        InputField(
                          prefixIcon: Icons.warning,
                          labelText: CustomLists.noteLabels[3],
                          controller: allergiesController,
                        ),
                        InputField(
                          prefixIcon: Icons.local_hospital,
                          labelText: CustomLists.noteLabels[4],
                          controller: priorSurgeriesController,
                        ),
                        InputField(
                          prefixIcon: Icons.date_range,
                          labelText: CustomLists.noteLabels[5],
                          controller: priorSurgeryDateController,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQueryUtils.getWidth(context) * .3,
                        child: ElevatedButton(
                          onPressed: _saveDataToFirestore,
                          child: Text('Add Note'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQueryUtils.getHeight(context) * .02,
                  )

                  // Details
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
