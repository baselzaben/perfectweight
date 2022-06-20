// ignore_for_file: non_constant_identifier_names


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectweight/screens/result_screen.dart';

import 'dart:math';

import '../GlobalVaribales.dart';
import '../constants.dart';
import '../widget/base/base_screen.dart';
import '../widget/gender_container.dart';
import '../widget/height_container.dart';
import '../widget/selector_container.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class macros_screen extends StatefulWidget {
  const macros_screen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<macros_screen> {


  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onButtonPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      },
      buttonText: 'رجوع',
      childWidget: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                width: 150,
                height: 150,
                child: Image.network(
                    Globalvireables.image /* 'https://picsum.photos/250?image=9',*/
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text("g السعرات الحرارية لكل 100 ",style: TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w900
                ),),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(Globalvireables.energy_100g,style: TextStyle(
                    fontSize: 30,fontWeight: FontWeight.w900
                ),),
              ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(" g "+Globalvireables.proteins,style: TextStyle(
                  fontSize: 18,fontWeight: FontWeight.w900
              ),),
            ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text("بروتين",style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.w700
                ),),
              ),


            ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(" g "+Globalvireables.carbohydrates,style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w900
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("النشويات",style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w700
                      ),),
                    ),


                  ]),


              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(" g "+Globalvireables.fat,style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w900
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("الدهون",style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w700
                      ),),
                    ),


                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(" g "+Globalvireables.sugars,style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w900
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("السكر",style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w700
                      ),),
                    ),


                  ]),


            ],
          ),
        ),
      ),
    );
  }




}
