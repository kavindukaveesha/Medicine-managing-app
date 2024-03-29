import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinapp/common/custom_shape/widgets/pluss_button/pluss_button.dart';
import 'package:medicinapp/features/pages/screens/oppinment/add_oppinment.dart';
import 'package:medicinapp/features/pages/screens/oppinment/update_appoinment.dart';

import '../../../../common/custom_shape/widgets/whiteBoxContainer/white_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/mediaQuery.dart';

class OppoinmentCard extends StatefulWidget {
  const OppoinmentCard({
    super.key,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.location,
    required this.number,
    required this.appointmentId,
    required this.onTapdelete,
  });
  final String doctorName, date, time, location;
  final int number;
  final String appointmentId;
  final VoidCallback onTapdelete;

  @override
  State<OppoinmentCard> createState() => _OppoinmentCardState();
}

class _OppoinmentCardState extends State<OppoinmentCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CustomContainer(
        width: MediaQueryUtils.getWidth(context) * .9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.doctorName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: TColors.textSecondary, fontSize: 20),
                    ),
                    PlussButton(onTap: () {
                      Get.to(() => AddAppointment());
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Day',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              widget.date,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: TColors.textSecondary),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              widget.time,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: TColors.textSecondary),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Number',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '${widget.number}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: TColors.textSecondary),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQueryUtils.getHeight(context) * .02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.location,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: TColors.textSecondary),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Check Appointment'),
                            content: Text('Have you taken the appointment?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  widget
                                      .onTapdelete(); // Invoke the onTapdelete function
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Attended'),
                    ),
                    Row(
                      children: [
                        Text(
                          'Update Appointment',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        IconButton(
                            onPressed: () {
                              Get.to(() => UpdateAppointment(
                                  appointmentId: widget.appointmentId));
                            },
                            icon: Icon(Icons.update_sharp))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQueryUtils.getHeight(context) * .02,
              )
            ],
          ),
        ),
      ),
    );
  }
}
