import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/utils/constants/colors.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

class MedicalInfo extends StatefulWidget {
  const MedicalInfo({super.key});

  @override
  State<MedicalInfo> createState() => _MedicalInfoState();
}

class _MedicalInfoState extends State<MedicalInfo> {
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

  Stream<QuerySnapshot> getUserspecialNotesDetails() {
    // Reference the current user's document
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('app_user')
        .doc(_currentUser!.email);

    // Get user's appointments from Firestore
    return userDocRef.collection('special_notes').snapshots();
  }

  Stream<QuerySnapshot> getUserAppointments() {
    // Reference the current user's document
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('app_user')
        .doc(_currentUser!.email);

    // Get user's appointments from Firestore
    return userDocRef.collection('appointments').snapshots();
  }

  Stream<QuerySnapshot> getuserMedications() {
    // Reference the current user's document
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('app_user')
        .doc(_currentUser!.email);

    // Get user's appointments from Firestore
    return userDocRef.collection('medications').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = []; // Initialize rows list

    return CustomWidget(
      isShowback: true,
      title: '',
      child: Align(
        alignment: Alignment.center,
        child: CustomContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medical Info',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: MediaQueryUtils.getHeight(context) * .02,
                ),

                // User Profile Details
                SizedBox(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('app_user')
                        .doc(_currentUser!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.hasData && snapshot.data!.exists) {
                        var userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        String name = userData['Full Name'] ?? '';
                        String gender = userData['Gender'] ?? '';
                        String age = userData['Age']?.toString() ?? '';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: TColors.appPrimaryColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                children: [
                                  TextRow(label: 'Gender', details: gender),
                                  TextRow(label: 'Age', details: age),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text(
                            'No data available'); // Show a message if the document for the current user doesn't exist
                      }
                    },
                  ),
                ),

                SizedBox(
                  height: MediaQueryUtils.getHeight(context) * .04,
                ),
                // This is appointment details
                InfoStreamCustomRow(
                    stream: getUserAppointments(),
                    field1: 'doctorName',
                    field2: 'appointmentDate',
                    title: 'Appointments'),
                // This is appointment details

                // This is medications details
                InfoStreamCustomRow(
                    stream: getuserMedications(),
                    field1: 'medName',
                    field2: 'medicineStrength',
                    title: 'Medicine Details'),
                // This is medications details
                // This is vaccinations details
                InfoStreamCustomRow(
                    stream: getUserspecialNotesDetails(),
                    field1: 'Vaccination Name',
                    field2: 'Vaccination Date',
                    title: 'Vaccinations'),
                // This is vaccinations details

                // This is Prior Surgeries details
                InfoStreamCustomRow(
                    stream: getUserspecialNotesDetails(),
                    field1: 'Prior Surgeries',
                    field2: 'Prior Surgery Date',
                    title: 'Prior Sergeries'),
                // This is Prior Surgeries details

                // This is Alagics details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allergies',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: TColors.appPrimaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: SizedBox(
                        height: 100,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: getUserspecialNotesDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Text(
                                  'No data available'); // Show a message if there is no data
                            }
                            // If there is data available, build a ListView using the data
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var item = snapshot.data!.docs[index];
                                String allegics = item['Allergies'];

                                return Text('$allegics',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // This is Alagics details
              ],
            ),
          ),
          width: MediaQueryUtils.getWidth(context) * .9,
        ),
      ),
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({Key? key, required this.label, required this.details})
      : super(key: key);

  final String label, details;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Adjust main axis alignment
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Color.fromARGB(255, 22, 37, 44)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .2, // Adjust width
        ),
        Text(
          details,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Color.fromARGB(255, 22, 37, 44)),
        ),
      ],
    );
  }
}

class InfoStreamCustomRow extends StatelessWidget {
  final Stream<QuerySnapshot>? stream;
  final String field1;
  final String field2;
  final String title;

  const InfoStreamCustomRow({
    Key? key,
    required this.stream,
    required this.field1,
    required this.field2,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: TColors.appPrimaryColor), // Adjust text color
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            height: 100,
            child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No data available');
                }
                return SizedBox(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data!.docs[index];
                      String vacName = item[field1];
                      String vacDate = item[field2];
                      return TextRow(label: vacName, details: vacDate);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
