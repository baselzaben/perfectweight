// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../custom_button.dart';
import 'navigation_drawer.dart';

class BaseScreen extends StatefulWidget {
  final Widget childWidget;
  final VoidCallback onButtonPressed;
  final String buttonText;

  const BaseScreen({
    required this.childWidget,
    required this.onButtonPressed,
    required this.buttonText,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0), child:AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          centerTitle: true,
          title: const Text(
            'BMI',
            style: TextStyle(color: kTextColor, fontWeight: FontWeight.w400),
          ),
        ) ,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: widget.childWidget,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(widget.buttonText, widget.onButtonPressed),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        //drawer: const NavigationDrawer(),
      ),
    );
  }
}
