import 'package:flutter/material.dart';
import '../../../../utils/constants/mediaQuery.dart';
import '../whiteBoxContainer/white_container.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard(
      {super.key,
      required this.medicineName,
      required this.medText,
      required this.image,
      required this.pillStrength, });
  final String medicineName;
  final String medText;
  final String pillStrength;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomContainer(
        width: MediaQueryUtils.getWidth(context) * .55,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                image,
                width: MediaQueryUtils.getWidth(context) * .1,
                height: MediaQueryUtils.getWidth(context) * .1,
                fit: BoxFit.cover,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicineName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w800),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      medText,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      pillStrength,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                   
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
