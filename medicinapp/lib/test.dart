import 'package:flutter/material.dart';
import 'package:medicinapp/common/custom_shape/widgets/custom_page_widget/custom_widget.dart';
import 'package:medicinapp/utils/constants/colors.dart';
import 'package:medicinapp/utils/constants/image_strings.dart';
import 'package:medicinapp/utils/constants/mediaQuery.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        isShowback: false,
        title: 'Hello Kavindu! Welcome',
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  'I have register to firebase.now you can start develop your pages.After finishing comit and pull to test branch'),
            ),
            Container(
                width: MediaQueryUtils.getWidth(context) * .9,
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                  borderRadius:
                      BorderRadius.circular(10), // Set the border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.5), // Set the color and opacity of the shadow
                      spreadRadius: 5, // Set the spread radius
                      blurRadius: 7, // Set the blur radius
                      offset: Offset(0, 3), // Set the offset of the shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Text(
                        'Add Medication',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    MyButtonsRow(),
                    // Form Start
                    // Form end
                  ],
                )),
          ],
        ));
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

class MyButtonsRow extends StatefulWidget {
  @override
  _MyButtonsRowState createState() => _MyButtonsRowState();
}

class _MyButtonsRowState extends State<MyButtonsRow> {
  int? _selectedButtonId;
  String? _selectedImageUrl;

  void _onButtonPressed(String imageUrl, int buttonId) {
    setState(() {
      _selectedButtonId = buttonId;
      _selectedImageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
          imageUrl: MediImages.m1,
          buttonId: 4,
          onPressed: _onButtonPressed,
          isSelected: _selectedButtonId == 4,
        ),
      ],
    );
  }
}
