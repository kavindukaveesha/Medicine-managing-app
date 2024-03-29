import 'package:flutter/material.dart';

class DayPickerDropdown extends StatefulWidget {
  DayPickerDropdown({
    Key? key,
    required this.listName,
    required this.onDaySelected,
    this.selectedItem,
    // New property for the callback function
  }) : super(key: key);

  final List<String> listName;
  final Function(DateTime) onDaySelected;

  String? selectedItem; // Change to nullable String

  @override
  _DayPickerDropdownState createState() => _DayPickerDropdownState();
}

class _DayPickerDropdownState extends State<DayPickerDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
          icon: Icon(Icons.keyboard_arrow_down),
          iconEnabledColor: Colors.black,
          iconSize: 30,
          value: widget.selectedItem,
          style: Theme.of(context)
              .textTheme
              .headlineMedium, // Use headline6 instead of headlineMedium
          onChanged: (newValue) {
            setState(() {
              widget.selectedItem = newValue;
              // Get the DateTime object for the selected day
              DateTime selectedDate =
                  _getDateForDay(newValue!); // Remove null check
              // Call the callback function with the selected date
              widget.onDaySelected(selectedDate);
            });
          },
          items: widget.listName.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Function to get the DateTime object for the selected day
  DateTime _getDateForDay(String day) {
    // Get the index of the selected day in the list
    int index = widget.listName.indexOf(day);
    // Get the current date
    DateTime currentDate = DateTime.now();
    // Calculate the difference in days between the current day and the selected day
    int difference = index - currentDate.weekday;
    // Add the difference to the current date to get the selected date
    return currentDate.add(Duration(days: difference));
  }
}
