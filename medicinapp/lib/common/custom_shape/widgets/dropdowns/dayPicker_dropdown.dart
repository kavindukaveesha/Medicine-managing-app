import 'package:flutter/material.dart';

class DayPickerDropdown extends StatefulWidget {
  const DayPickerDropdown({
    Key? key,
    required this.listName,
  }) : super(key: key);

  final List<String> listName;

  @override
  _DayPickerDropdownState createState() => _DayPickerDropdownState();
}

class _DayPickerDropdownState extends State<DayPickerDropdown> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    // Get the current day of the week and set it as the initial value
    final currentDay = DateTime.now().weekday;
    _selectedItem =
        widget.listName[currentDay - 1]; // Adjust index to start from 0
    // Notify the parent widget about the initial selection
  }

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
          value: _selectedItem,
          style: Theme.of(context).textTheme.headlineMedium,
          onChanged: (newValue) {
            setState(() {
              _selectedItem = newValue!;
              print(_selectedItem);
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
}
