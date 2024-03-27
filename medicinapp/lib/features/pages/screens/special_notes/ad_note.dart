import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/common/custom_shape/widgets/text_inputs/text_input_field.dart';
import 'package:medicinapp/common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

class AddSpecialNotePage extends StatefulWidget {
  const AddSpecialNotePage({Key? key});

  @override
  State<AddSpecialNotePage> createState() => _AddSpecialNotePageState();
}

class _AddSpecialNotePageState extends State<AddSpecialNotePage> {
  @override
  Widget build(BuildContext context) {
    final String noData = 'No Data add Still';
    List<String> labels = [
      'Vaccination Name',
      'Vaccination Date',
      'Vaccination Dose',
      'Allergies',
      'Prior Surgeries',
      'Prior Surgery Date'
    ];
    // Remove unnecessary variable _dateTime

    // Function to handle date selection and update the controller
    void _selectDate(TextEditingController controller) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        // Format the selected date
        String formattedDate = "${picked.year}-${picked.month}-${picked.day}";
        // Set the formatted date to the controller
        controller.text = formattedDate;
      }
    }

    final TextEditingController vaccinationNameController =
        TextEditingController();
    final TextEditingController vaccinationDateController =
        TextEditingController();
    final TextEditingController vaccinationDoseController =
        TextEditingController();
    final TextEditingController allergiesController = TextEditingController();
    final TextEditingController priorSergeriesController =
        TextEditingController();
    final TextEditingController priorSergeriesDateController =
        TextEditingController();

    @override
    void dispose() {
      vaccinationNameController.dispose();
      vaccinationDateController.dispose();
      vaccinationDoseController.dispose();
      allergiesController.dispose();
      priorSergeriesController.dispose();
      priorSergeriesDateController.dispose();
      super.dispose();
    }

    return CustomWidget(
      isShowback: true,
      title: 'Add Your Special Notes Here....',
      child: Column(
        children: [
          SizedBox(
            height: MediaQueryUtils.getHeight(context) * .05,
          ),
          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Special Note',
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
                        suffixIconButton: IconButton(
                            onPressed: () {}, icon: Icon(Icons.calendar_today)),
                        labelText: labels[0],
                        controller: vaccinationNameController,
                      ),
                      InputField(
                        labelText: labels[1],
                        controller: vaccinationDateController,
                      ),
                      InputField(
                        labelText: labels[2],
                        controller: vaccinationDoseController,
                      ),
                      InputField(
                        labelText: labels[3],
                        controller: allergiesController,
                      ),
                      InputField(
                        labelText: labels[4],
                        controller: priorSergeriesController,
                      ),
                      InputField(
                        labelText: labels[5],
                        controller: priorSergeriesDateController,
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
                        onPressed: () {},
                        child: Text('Add'),
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
        ],
      ),
    );
  }
}
