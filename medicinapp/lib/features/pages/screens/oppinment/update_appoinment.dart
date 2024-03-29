import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicinapp/common/custom_shape/widgets/snack_bar/snack_bar.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/features/pages/screens/home_page/home_page.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';
import 'package:medicinapp/common/custom_shape/widgets/text_inputs/text_input_field.dart';

class UpdateAppointment extends StatefulWidget {
  final String appointmentId;

  const UpdateAppointment({Key? key, required this.appointmentId})
      : super(key: key);

  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController appointmentLocationController =
      TextEditingController();
  final TextEditingController appointmentNumberController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Initialize selectedDate with current date
    selectedTime = TimeOfDay.now(); // Initialize selectedTime with current time
    fetchAppointmentData();

    FirebaseFirestore.instance
        .collection('appointments')
        .doc(widget.appointmentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          print('Doctor Name: ${data['doctorName']}');
          doctorNameController.text = data['doctorName'];
          print('Appointment Location: ${data['appointmentLocation']}');
          appointmentLocationController.text = data['appointmentLocation'];
          print('Appointment Number: ${data['appointmentNumber']}');
          appointmentNumberController.text = data['appointmentNumber'];
          print('Selected Date: $selectedDate');
          selectedDate = DateTime.parse(data['appointmentDate']);
          print('Selected Time: $selectedTime');
          selectedTime = TimeOfDay(
            hour: int.parse(data['appointmentTime'].split(':')[0]),
            minute: int.parse(data['appointmentTime'].split(':')[1]),
          );
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void _submitForm() {
    final form = _formKey.currentState;

    updateAppointmentInFirestore();
  }

  Future<void> updateAppointmentInFirestore() async {
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
          .collection('appointments')
          .doc(widget.appointmentId)
          .update({
        'doctorName': doctorNameController.text.trim(),
        'appointmentDate': appointmentDateStr,
        'appointmentTime': appointmentTimeStr,
        'appointmentNumber': appointmentNumberController.text.trim(),
        'appointmentLocation': appointmentLocationController.text.trim(),
        'day': dayName,
      });

      // Show success message when appointment is updated successfully
      SnackbarHelper.showSnackbar(
          title: 'Success', message: 'Appointment updated successfully!');
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const HomePage());
      });
    } catch (e) {
      // Show error message if updating appointment fails
      SnackbarHelper.showSnackbar(
          title: 'Error',
          message: 'Failed to update appointment: $e',
          backgroundColor: Colors.red);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
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

  Future<void> fetchAppointmentData() async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(widget.appointmentId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          doctorNameController.text = data['doctorName'];
          appointmentLocationController.text = data['appointmentLocation'];
          appointmentNumberController.text = data['appointmentNumber'];
          selectedDate = DateTime.parse(data['appointmentDate']);
          selectedTime = TimeOfDay(
            hour: int.parse(data['appointmentTime'].split(':')[0]),
            minute: int.parse(data['appointmentTime'].split(':')[1]),
          );
        });
      } else {
        print('Document does not exist on the database');
      }
    } catch (e) {
      print('Error fetching appointment data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Appointment'),
      ),
      body: SingleChildScrollView(
        child: Align(
          child: CustomContainer(
            width: MediaQueryUtils.getWidth(context) * .9,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputField(
                    labelText: 'Doctor\'s Name',
                    controller: doctorNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: TextEditingController(
                                text: DateFormat('dd/MM/yyyy')
                                    .format(selectedDate),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Appointment Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
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
                  SizedBox(height: 16.0),
                  InputField(
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
                  SizedBox(height: 16.0),
                  InputField(
                    labelText: 'Appointment Location',
                    controller: appointmentLocationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the appointment location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Update Appointment'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
