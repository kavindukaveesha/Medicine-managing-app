import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medicinapp/features/pages/screens/medication/add_medication.dart';
import 'package:medicinapp/features/pages/screens/user_profile/user_logout.dart';

import '../../features/pages/screens/home_page/home_page.dart';
import '../../features/pages/screens/medical_info/medical_info.dart';
import '../../features/pages/screens/oppinment/add_oppinment.dart';
import '../../features/pages/screens/special_notes/ad_note.dart';
import '../../features/pages/screens/user_profile/user_profile.dart';

class CustomLists {
  static List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  static List<Map<String, dynamic>> drawerItems = [
    {
      'title': 'Home',
      'onTap': () {
        Get.to(() => HomePage());
      }
    },
    {
      'title': 'Add Medications',
      'onTap': () {
        Get.to(() => AddMedication());
      }
    },
    {
      'title': 'Add Appointment',
      'onTap': () {
        Get.to(() => AddAppointment());
      }
    },
    {
      'title': 'Medical Info',
      'onTap': () {
        Get.to(() => MedicalInfo());
      }
    },
    {
      'title': 'Special Notes',
      'onTap': () {
        Get.to(() => AddSpecialNotePage());
      }
    },
    {
      'title': 'User Profile',
      'onTap': () {
        Get.to(() => UserProfile());
      }
    },
    {
      'title': 'Logout',
      'onTap': () {
        Get.to(() => LogoutUser());
      }
    },
  ];

  static List<String> profileDetailsLabels = [
    'Full Name',
    'Email',
    'Age',
    'Gender',
    'Language',
    'Country'
  ];

  // Notes Labels
  static List<String> noteLabels = [
    'Vaccination Name',
    'Vaccination Date(dd/mm/yyyy)',
    'Vaccination Dose',
    'Allergies',
    'Prior Surgeries',
    'Prior Surgery Date(dd/mm/yyyy)'
  ];
}
