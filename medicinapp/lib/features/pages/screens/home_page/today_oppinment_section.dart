import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/features/pages/screens/oppinment/add_oppinment.dart';
import 'package:medicinapp/features/pages/screens/oppinment/oppointment_display_card.dart';
import 'package:medicinapp/utils/constants/image_strings.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';
import '../../../../common/custom_shape/widgets/snack_bar/snack_bar.dart';
import '../../../../utils/constants/colors.dart'; // Import Firestore library

class TodayoppintmentSection extends StatefulWidget {
  const TodayoppintmentSection({Key? key, required this.selectedDay})
      : super(key: key);
  final String selectedDay;

  @override
  State<TodayoppintmentSection> createState() => _TodayoppintmentSectionState();
}

class _TodayoppintmentSectionState extends State<TodayoppintmentSection> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

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

  Stream<QuerySnapshot> getUserAppointments() {
    // Reference the current user's document
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('app_user')
        .doc(_currentUser!.email);

    // Get user's appointments from Firestore
    return userDocRef
        .collection('appointments')
        .where('day', isEqualTo: widget.selectedDay)
        .snapshots();
  }

  // Add this method to delete a specific appointment document
  void deleteAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('app_user')
        .doc(_currentUser!.email)
        .collection('appointments')
        .doc(appointmentId)
        .delete()
        .then((_) {
      SnackbarHelper.showSnackbar(
          title: 'Success', message: 'Delete Appointment Successfully');
    }).catchError((error) {
      SnackbarHelper.showSnackbar(
          title: 'Error',
          message: error.toString(),
          backgroundColor: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUserAppointments(),
      builder: (context, snapshot) {
        print("Selected Day: ${widget.selectedDay}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Snapshot Connection State: Waiting");
          return Center(
            child:
                CircularProgressIndicator(), // Show loading indicator while fetching data
          );
        }
        if (snapshot.hasError) {
          print("Snapshot Error: ${snapshot.error}");
          return Center(
            child: Text('Error: ${snapshot.error}'), // Show error if any
          );
        }
        // If no error and data is available
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          print("Snapshot Data Length: ${snapshot.data!.docs.length}");
          // Render appointment cards based on fetched data
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Your Next Appointments',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: TColors.textSecondary,
                              ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Slide to next..',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.355,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var sortedAppointments = snapshot.data!.docs.toList()
                      ..sort((a, b) =>
                          a['appointmentDate'].compareTo(b['appointmentDate']));
                    var appointmentData = sortedAppointments[index];
                    String doctorName = appointmentData['doctorName'];
                    String date = appointmentData['appointmentDate'];
                    String time = appointmentData['appointmentTime'];
                    String location = appointmentData['day'];
                    int number =
                        int.parse(appointmentData['appointmentNumber']);
                    String appointmentId = appointmentData.id;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OppoinmentCard(
                        doctorName: doctorName,
                        date: date,
                        time: time,
                        location: location,
                        number: number,
                        appointmentId: appointmentId,
                        onTapdelete: () {
                          deleteAppointment(appointmentId);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        // If no data available
        return Align(
          alignment: Alignment.center,
          child: CustomContainer(
            width: MediaQueryUtils.getWidth(context) * .9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      MediImages.m4,
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
                        Text(
                            'No appointments available for ${widget.selectedDay}.'),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(() => AddAppointment());
                            },
                            child: Text('Add New Oppintment'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
