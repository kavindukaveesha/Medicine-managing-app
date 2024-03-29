import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/common/custom_shape/widgets/dropdowns/dropdown1.dart';
import 'package:medicinapp/common/custom_shape/widgets/snack_bar/snack_bar.dart';
import 'package:medicinapp/common/custom_shape/widgets/text_inputs/text_input_field.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';
import 'package:medicinapp/utils/validators/validation.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../home_page/home_page.dart';

List<String> dropdownOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
List<String> count = ['Enter Medication Dose', '1', '2', '3', '4', '5'];
List<String> datFrequency = ['How many times per day', '1', '2', '3', '4', '5'];

List<String> strenghtOfMedication = [
  'Strength of Medication in mg/ml',
  '10',
  '20',
  '30',
  '40',
  '50',
  '60',
  '70',
  '80',
  '90',
  '100'
];
List<String> timeSelect = ['At what time take ', 'After', 'Before'];

class AddMedication extends StatefulWidget {
  const AddMedication({Key? key});

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        isShowback: true,
        title: '',
        child: Align(
          alignment: Alignment.center,
          child: CustomContainer(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Text(
                      'Add Medication',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  MyButtonsRow(),
                ],
              ),
              width: MediaQueryUtils.getWidth(context) * .9),
        ));
  }
}

class MyButtonsRow extends StatefulWidget {
  @override
  _MyButtonsRowState createState() => _MyButtonsRowState();
}

class _MyButtonsRowState extends State<MyButtonsRow> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  int? _selectedButtonId;
  String? medStrength;
  String? takeTime;
  late TimeOfDay selectedTime = TimeOfDay.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> selectedDays = [];
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
      saveMedicationData();
    }
  }

  void _onButtonPressed(String imageUrl, int buttonId) {
    setState(() {
      _selectedButtonId = buttonId;
      print(_selectedButtonId);
    });
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

  TextEditingController medicineDoseController = TextEditingController();
  TextEditingController takeTimeController = TextEditingController();
  TextEditingController medicineStrengthController = TextEditingController();
  TextEditingController selectedTimeController = TextEditingController();
  TextEditingController inventoryAmountController = TextEditingController();
  TextEditingController refillController = TextEditingController();
  TextEditingController medNameController = TextEditingController();

  Future<void> saveMedicationData() async {
    // Retrieve data from controllers
    final appointmentTime =
        TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute);
    final appointmentTimeStr =
        '${appointmentTime.hour}:${appointmentTime.minute.toString().padLeft(2, '0')}';
    int medicineDose = int.parse(medicineDoseController.text.trim());
    String rememberTime = appointmentTimeStr;
    int inventoryAmount = int.parse(inventoryAmountController.text.trim());
    int refillAmount = int.parse(refillController.text.trim());
    String medName = medNameController.text.trim();
    int medStrength = int.parse(medicineStrengthController.text.trim());
    List<String> daysOfWeek = selectedDays;

    try {
      await FirebaseFirestore.instance
          .collection('app_user')
          .doc(_currentUser!.email)
          .collection('medications')
          .add({
        'medId': _selectedButtonId,
        'medName': medName,
        'medicineDose': medicineDose,
        'takeTime': takeTime,
        'medicineStrength': medStrength,
        'rememberTime': rememberTime,
        'inventoryAmount': inventoryAmount,
        'refillAmount': refillAmount,
        'selectDays': daysOfWeek
        // Add more fields as needed
      });

      // Clear controllers and show success message
      medicineDoseController.clear();
      medNameController.clear();
      selectedTimeController.clear();
      medicineStrengthController.clear();
      inventoryAmountController.clear();
      refillController.clear();

      SnackbarHelper.showSnackbar(
          title: 'Success', message: 'Added a medication successfully');
      Future.delayed(const Duration(seconds: 5), () {
        Get.offAll(() => const HomePage());
      });
    } catch (error) {
      // Handle errors
      print('Error: $error');
      SnackbarHelper.showSnackbar(
          title: 'Error',
          message: error.toString(),
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundButton(
            imageUrl: MediImages.m1,
            buttonId: 1,
            onPressed: _onButtonPressed,
            isSelected: _selectedButtonId == 1,
          ),
          RoundButton(
            imageUrl: MediImages.m2,
            buttonId: 2,
            onPressed: _onButtonPressed,
            isSelected: _selectedButtonId == 2,
          ),
          RoundButton(
            imageUrl: MediImages.m3,
            buttonId: 3,
            onPressed: _onButtonPressed,
            isSelected: _selectedButtonId == 3,
          ),
          RoundButton(
            imageUrl: MediImages.m4,
            buttonId: 4,
            onPressed: _onButtonPressed,
            isSelected: _selectedButtonId == 4,
          ),
        ],
      ),
      SizedBox(
        height: MediaQueryUtils.getHeight(context) * .05,
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                  controller: medNameController,
                  validator: Validator.communValidete,
                  labelText: 'Enter Medication Name'),
              InputField(
                  controller: medicineDoseController,
                  validator: Validator.communValidete,
                  keyboardtype: TextInputType.number,
                  labelText: 'Enter Medication Dose'),
              Dropdown1(
                validator: Validator.communValidete,
                listName: timeSelect,
                onItemSelected: (value) {
                  takeTime = value;
                  takeTimeController.text = value;
                },
              ),
              Dropdown1(
                validator: Validator.communValidete,
                listName: strenghtOfMedication,
                onItemSelected: (value) {
                  medStrength = value;
                  medicineStrengthController.text = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Madication Taking Days',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: daysOfWeek.map((day) {
                        return FilterChip(
                          label: Text(day),
                          selected: selectedDays.contains(day),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                selectedDays.add(day);
                              } else {
                                selectedDays.remove(day);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectTime(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            validator: Validator.communValidete,
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
              InputField(
                controller: inventoryAmountController,
                validator: Validator.communValidete,
                labelText: 'Enter Inventory Amount(mg/ml)',
              ),
              InputField(
                  validator: Validator.communValidete,
                  labelText: 'Refill Remainder Amount(mg/ml)',
                  controller: refillController),
            ],
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQueryUtils.getWidth(context) * 0.5,
            child: ElevatedButton(
              onPressed: () {
                saveMedicationData();
              },
              child: Text('Add Medication'),
            ),
          ),
        ],
      ),
      SizedBox(
        height: MediaQueryUtils.getHeight(context) * 0.02,
      )
    ]);
  }
}

class RoundButton extends StatefulWidget {
  final String imageUrl;
  final int buttonId;
  final Function(String imageUrl, int buttonId) onPressed;
  final bool isSelected;

  const RoundButton({
    Key? key,
    required this.imageUrl,
    required this.buttonId,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed(widget.imageUrl, widget.buttonId);
      },
      child: Container(
        width: widget.isSelected ? 55 : 50,
        height: widget.isSelected ? 55 : 50,
        decoration: BoxDecoration(
          color: widget.isSelected ? TColors.success : Colors.grey[200],
          borderRadius: BorderRadius.circular(
            widget.isSelected ? 55 : 50,
          ),
        ),
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            widget.imageUrl,
          ),
        ),
      ),
    );
  }
}

// class DP1 extends StatefulWidget {
//   @override
//   _DP1State createState() => _DP1State();
// }

// class _DP1State extends State<DP1> {
//   String _selectedOption = '';
//   TextEditingController _textEditingController = TextEditingController();

//   List<String> _dropdownOptions = [
//     'Option 1',
//     'Option 2',
//     'Option 3',
//     'Option 4'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TextInput & Dropdown Example'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Text',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             DropdownButtonFormField(
//               value: _selectedOption,
//               items: _dropdownOptions.map((option) {
//                 return DropdownMenuItem(
//                   value: option,
//                   child: Text(option),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedOption = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Select Option',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             GestureDetector(
//               onTap: () {
//                 // Handle button press here
//                 print('Entered Text: ${_textEditingController.text}');
//                 print('Selected Option: $_selectedOption');
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
