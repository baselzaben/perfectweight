
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import 'custom_button.dart';

class CustomeAlertDialog extends StatelessWidget {
  const CustomeAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'هل تريد العودة للشاشة الرئيسية ؟',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton('نعم', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          }),
          CustomButton('لا', () {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
