import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicinapp/common/custom_shape/widgets/dropdowns/dayPicker_dropdown.dart';
import 'package:medicinapp/common/custom_shape/widgets/messages/info_massage/info_message.dart';
import 'package:medicinapp/features/authentication/screens/log_in_screen/log_in_screen.dart';
import 'package:medicinapp/features/pages/screens/home_page/refil_section.dart';
import 'package:medicinapp/features/pages/screens/home_page/today_medication_section.dart';
import 'package:medicinapp/features/pages/screens/home_page/today_oppinment_section.dart';

import 'package:medicinapp/utils/constants/mediaQuery.dart';
import 'package:medicinapp/utils/lists/custom_lists.dart';

import '../../../../common/custom_shape/widgets/custom_page_widget/custom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? selectedFullDate;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _currentUser;

  void _getCurrentUser() {
    final currentUser = _auth.currentUser;
    setState(() {
      _currentUser = currentUser;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeSelectedDay();
    _getCurrentUser();
  }

  void _initializeSelectedDay() {
    final now = DateTime.now();
    selectedDay = DateFormat('EEEE').format(now); // Get the day name
    selectedFullDate =
        DateFormat('yyyy-MM-dd').format(now); // Get the full date
  }

  void _handleDaySelection(DateTime selectedDate) {
    final dayName = DateFormat('EEEE').format(selectedDate); // Get the day name
    final fullDate =
        DateFormat('yyyy-MM-dd').format(selectedDate); // Get the full date

    setState(() {
      selectedDay = dayName;
      selectedFullDate = fullDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
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
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['Full Name'] ?? '';
          return Scaffold(
            body: CustomWidget(
              isShowback: false,
              title: 'Welcome, $name',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DayPickerDropdown(
                      listName: CustomLists.days,
                      onDaySelected: _handleDaySelection,
                      selectedItem:
                          selectedDay ?? '', // Pass the callback function
                    ),
                    // Oppointment Section
                    TodayoppintmentSection(
                      selectedDay: selectedDay ?? '', // Pass selectedDay
                    ),
                    // Oppointment Section
                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * 0.05,
                    ),
                    // Today Medication Section
                    TodayMedicationSection(
                      selectedDay: selectedDay ?? '',
                    ),
                    // Today Medication Section
                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * 0.02,
                    ),
                    // Refill section
                    RefillSection(),
                    // Refill section
                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * 0.02,
                    ),
                    // End of refill section
                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * 0.01,
                    ),

                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Handle case where snapshot has no data or does not exist
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No user data found.'),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => LogInScreen());
                  },
                  child: Text('SignIn'))
            ],
          ));
        }
      },
    ));
  }
}
