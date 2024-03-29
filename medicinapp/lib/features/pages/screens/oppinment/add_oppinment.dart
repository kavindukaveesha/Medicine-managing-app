import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/common/custom_shape/widgets/snack_bar/snack_bar.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

import '../../../../common/custom_shape/widgets/text_inputs/text_input_field.dart';
import '../home_page/home_page.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      addAppointmentToFirestore();
    }
  }

  Future<void> addAppointmentToFirestore() async {
    final appointmentDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final appointmentTime =
        TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute);
    final String dayName = DateFormat('EEEE').format(appointmentDate);
    final appointmentDateStr = DateFormat('yyyy-MM-dd').format(appointmentDate);
    final appointmentTimeStr =
        '${appointmentTime.hour}:${appointmentTime.minute.toString().padLeft(2, '0')}';

    try {
      await FirebaseFirestore.instance
          .collection(
              'app_user') // Change 'users' to the collection where user documents are stored
          .doc(_currentUser!
              .email) // Use 'uid' instead of 'email' for unique user identification
          .collection(
              'appointments') // Add appointments to a subcollection under each user document
          .add({
        'doctorName': doctorNameController.text.trim(),
        'appointmentDate': appointmentDateStr,
        'appointmentTime': appointmentTimeStr,
        'appointmentNumber': appointmentNumberController.text.trim(),
        'appointmentLocation': appointmentLocationController.text.trim(),
        'day': dayName,
      });

      SnackbarHelper.showSnackbar(
          title: "Success", message: 'Appointment added successfully!');
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const HomePage());
      });

      doctorNameController.clear();
      appointmentLocationController.clear();
      appointmentNumberController.clear();
      setState(() {
        selectedDate = DateTime.now();
        selectedTime = TimeOfDay.now();
      });
    } catch (e) {
      SnackbarHelper.showSnackbar(
          title: "Error", message: 'Failed to add appointment: $e');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2026),
      selectableDayPredicate: (DateTime date) {
        return date.isAfter(now.subtract(Duration(days: 1)));
      },
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController appointmentLocationController =
      TextEditingController();
  final TextEditingController appointmentNumberController =
      TextEditingController();

  @override
  void dispose() {
    doctorNameController.dispose();
    appointmentLocationController.dispose();
    appointmentNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      isShowback: false,
      title: '',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQueryUtils.getHeight(context) * .03,
            ),
            Align(
              alignment: Alignment.center,
              child: CustomContainer(
                width: MediaQueryUtils.getWidth(context) * .9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Appointment',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          InputField(
                            prefixIcon: Icons.person,
                            labelText: 'Doctor\'s Name',
                            controller: doctorNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the doctor\'s name';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => selectDate(context),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: DateFormat('dd/MM/yyyy').format(
                                              selectedDate), // Format date
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Appointment Date',
                                          suffixIcon:
                                              Icon(Icons.calendar_today),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQueryUtils.getWidth(context) *
                                        .01),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => selectTime(context),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: selectedTime.format(context),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Appointment Time',
                                          suffixIcon: Icon(Icons.access_time),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQueryUtils.getHeight(context) * .02,
                          ),
                          InputField(
                            prefixIcon: Icons.numbers,
                            keyboardtype: TextInputType.number,
                            controller: appointmentNumberController,
                            labelText: 'Appointment Number',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the appointment number';
                              }
                              return null;
                            },
                          ),
                          InputField(
                            prefixIcon: Icons.location_on,
                            labelText: 'Appointment Location',
                            controller: appointmentLocationController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the appointment location';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQueryUtils.getWidth(context) * .5,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            child: Text('Add Appointment'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * .02,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
