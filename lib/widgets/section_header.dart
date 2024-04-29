import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.action = 'View More',
    this.onTap,
  }) : super(key: key);

  final String title;
  final String action;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        // GestureDetector(
        //   onTap: onTap,
        //   child: Text(
        //     action,
        //     style: Theme.of(context)
        //         .textTheme
        //         .bodyLarge!
        //         .copyWith(color: Colors.white),
        //   ),
        // ),
      ],
    );
  }
}
