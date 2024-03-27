import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.keyboardtype,
    this.maxLength,
    this.maxLines, this.onTapDate, this.suffixIconButton,
    
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardtype;
  final int? maxLength;
  final int? maxLines;
  final VoidCallback? onTapDate;
  final IconButton? suffixIconButton;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: mediaQueryWidth * 0.8,
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardtype,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText, 
          suffixIcon: suffixIconButton,
        ),
      ),
    );
  }
}

// class AddSpecialNotePage extends StatelessWidget {
//   const AddSpecialNotePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<String> labels = [
//       'Vaccination Name',
//       'Vaccination Date',
//       'Vaccination Dose',
//       'Allergies',
//       'Prior Surgeries',
//       'Prior Surgery Date',
//     ];

//     void _selectDate() async {
//       final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2020),
//         lastDate: DateTime.now(),
//       );
//       if (picked != null) {
//         // Handle the selected date here
//         print('Selected date: $picked');
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Your Special Notes Here....'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Special Note',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             SizedBox(height: 20),
//             Column(
//               children: [
//                 for (var label in labels)
//                   InputField(
//                     labelText: label,
//                     onTapDate: () {
//                       if (labels.indexOf(label) == 1 || labels.indexOf(label) == 5) {
//                         _selectDate();
//                       }
//                     },
//                     suffixIconButton: labels.indexOf(label) == 1 || labels.indexOf(label) == 5
//                         ? IconButton(
//                             icon: Icon(Icons.calendar_today),
//                             onPressed: _selectDate,
//                           )
//                         : IconButton(
//                             icon: Icon(Icons.add),
//                             onPressed: () {
//                               // Handle other suffix icon button actions
//                             },
//                           ),
//                   ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Handle add button press
//                     },
//                     child: Text('Add'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
