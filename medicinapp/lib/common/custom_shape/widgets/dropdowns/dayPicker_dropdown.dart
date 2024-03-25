import 'package:flutter/material.dart';

class Daypicker extends StatefulWidget {
  const Daypicker({
    Key? key,
    required this.listName,
    required this.selectedItem,
  }) : super(key: key);

  final List<String> listName;
  final String selectedItem;

  @override
  _DaypickerState createState() => _DaypickerState();
}

class _DaypickerState extends State<Daypicker> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
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
          onChanged: (value) {
            setState(() {
              _selectedItem = value!;
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
