// ignore_for_file: use_key_in_widget_constructors


import 'package:flutter/material.dart';


import '../constants.dart';
import 'base/base_container.dart';
import 'circle_button.dart';

class SelectorContainer extends StatelessWidget {
  final String title;
  final String number;
  final VoidCallback increase;
  final VoidCallback decrease;

  const SelectorContainer({
    required this.title,
    required this.number,
    required this.increase,
    required this.decrease,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      childWidget: Column(
        children: [
          Text(
            title,
            style: kTextVariableStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            number,
            style: kNumberStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleButton(
                iconData: Icons.exposure_minus_1,
                onPressed: decrease,
              ),
              const SizedBox(
                width: 10,
              ),
              CircleButton(
                iconData: Icons.add,
                onPressed: increase,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
