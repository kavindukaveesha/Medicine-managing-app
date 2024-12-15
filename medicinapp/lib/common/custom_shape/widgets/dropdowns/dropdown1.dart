import 'package:flutter/material.dart';

class Dropdown1 extends StatefulWidget {
  const Dropdown1({
    Key? key,
    required this.listName,
    this.validator,
    required this.onItemSelected, // Add the onItemSelected callback
  }) : super(key: key);

  final List<String> listName;
  final String? Function(String?)? validator;
  final void Function(String)?
      onItemSelected; // Define the onItemSelected callback

  @override
  _Dropdown1State createState() => _Dropdown1State();
}

class _Dropdown1State extends State<Dropdown1> {
  late String _selectedItem; // New variable to hold the selected item

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.listName[
        0]; // Initialize the selected item with the first item in the list
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        validator: widget.validator,
        value: _selectedItem,
        items: widget.listName.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedItem = value!;
          });
          widget.onItemSelected?.call(
              value!); // Call the onItemSelected callback with the selected value
        },
      ),
    );
  }
}
