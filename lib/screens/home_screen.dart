// ignore_for_file: non_constant_identifier_names


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectweight/GlobalVaribales.dart';
import 'package:perfectweight/screens/macros_screen.dart';
import 'package:perfectweight/screens/result_screen.dart';

import 'dart:math';

import '../constants.dart';
import '../widget/base/base_screen.dart';
import '../widget/custom_button.dart';
import '../widget/gender_container.dart';
import '../widget/height_container.dart';
import '../widget/selector_container.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMaleActive = true;

  int age = 19, weight = 74;
String ?_scanBarcode;
  double height = 180;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onButtonPressed: () {
        my_navigator();
      },
      buttonText: 'أحــسب',
      childWidget: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
              onPressed: () {
                scanBarcodeNormal();


                },
          icon: Icon( // <-- Icon
            Icons.camera_alt_sharp,
            size: 24.0,
          ),
          label: Text('حساب السعرات الحرارية'), // <-- Text
        ),
              Row(
                children: [
                  GenderContainer(
                    text: 'ذكر',
                    avatar: 'assets/boy.png',
                    isActive: isMaleActive,
                    onTapped: () {
                      setState(() {
                        isMaleActive = true;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GenderContainer(
                    text: 'انثى',
                    avatar: 'assets/girl.png',
                    isActive: !isMaleActive,
                    onTapped: () {
                      setState(() {
                        isMaleActive = false;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  HeightContainer(
                    height,
                    (double value) {
                      setState(() {
                        height = value.round() * 1.0;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  SelectorContainer(
                    title: 'العمر',
                    number: age.toString(),
                    increase: () {
                      changeNumbers(isAgeChanging: true, isIncreasing: true);
                    },
                    decrease: () {
                      changeNumbers(isAgeChanging: true, isIncreasing: false);
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SelectorContainer(
                    
                    title: 'الوزن',
                    number: weight.toString(),
                    increase: () {
                      changeNumbers(isAgeChanging: false, isIncreasing: true);
                    },
                    decrease: () {
                      changeNumbers(isAgeChanging: false, isIncreasing: false);
                    },
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }

  void changeNumbers({
    required bool isAgeChanging,
    required bool isIncreasing,
  }) {
    if (isAgeChanging) {
      setState(() {
        if (isIncreasing) {
          if (age < 120) {
            age++;
          } else {
            // pass
          }
        } else {
          if (age > 1) {
            age--;
          } else {
            // pass
          }
        }
      });
    } //
    else {
      setState(() {
        if (isIncreasing) {
          if (weight < 500) {
            weight++;
          } else {
            // pass
          }
        } else {
          if (weight > 5) {
            weight--;
          } else {
            // pass
          }
        }
      });
    }
  }

  void my_navigator() {
    List result = bmiCalculator();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ResultScreen(
            statusColor: result[2],
            status: result[1],
            bmi: result[0].toString(),
            tip: result[3],
            moreTips: result[4],
            minWeight: result[5].toString(),
            maxWeight: result[6].toString(),
            dminWeight: result[7].toString(),
            dmaxWeight: result[8].toString(),
          );
        },
      ),
    );
  }

  List bmiCalculator() {
    double bmi = 0;
    String tip;
    String moreTips;
    Color statusColor;
    String status;
    double minWeight = 0, maxWeight = 0;
    double dminWeight = 0, dmaxWeight = 0;
    bmi = weight / pow((height / 100), 2);
    minWeight = (18.5 * pow((height / 100), 2)).ceilToDouble();
    maxWeight = (25.0 * pow((height / 100), 2)).floorToDouble();

    dminWeight = (weight - minWeight).abs();
    dmaxWeight = (weight - maxWeight).abs();

    if (bmi < 18.5) {
      status = 'تحت الوزن';
      tip =
          'قد يكون نقص الوزن علامة على أنك لا تأكل ما يكفي أو قد تكون مريضًا. ';
      moreTips = '\nإذا كنت تعاني من نقص الوزن ، يمكن للطبيب العام مساعدتك.';
      statusColor = kYellowGauge;
    } else if (bmi >= 18.5 && bmi <= 25) {
      status = 'طبيعي';
      statusColor = Colors.greenAccent;
      tip = 'ثابر على العمل الجيد';
      moreTips =
          '\n';
    } else if (bmi > 25 && bmi <= 30) {
      status = 'زيادة الوزن';
      tip =
          'أفضل طريقة لفقدان الوزن إذا كنت تعاني من زيادة الوزن هي الجمع بين النظام الغذائي والتمارين الرياضية.';
      moreTips =
          '\n';
      statusColor = kOrangeGauge;
    } else {
      status = 'سمين';
      tip =
          'أفضل طريقة لفقدان الوزن إذا كنت تعاني من السمنة هي الجمع بين النظام الغذائي والتمارين الرياضية.';
      moreTips =
          '\n';
      statusColor = kRedGauge;
    }

    return [
      bmi,
      status,
      statusColor,
      tip,
      moreTips,
      minWeight,
      maxWeight,
      dminWeight,
      dmaxWeight,
    ];
  }



  void scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      setState(() {
        _scanBarcode = barcodeScanRes;
        print(" barcodeScanRes :"+barcodeScanRes+"   ");

        fetchData2(barcodeScanRes);





      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }



  }
  Future fetchData2(String barcode) async {
    try {
      http.Response response;
      response = await http
          .get(
          Uri.parse("https://us.openfoodfacts.org/api/v0/product/" + barcode));
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        String proteins = mapResponse!["product"]['nutriments']['proteins_100g'].toString();
        String sugars = mapResponse!["product"]['nutriments']['sugars_100g'].toString();

        String carbohydrates = mapResponse!["product"]['nutriments']['carbohydrates_100g'].toString();
        String fat = mapResponse!["product"]['nutriments']['fat_100g'].toString();
        String _keywords = mapResponse!["product"]['_keywords'].toString();
        String image = mapResponse!["product"]['image_front_small_url'].toString();
        String energy_100g = mapResponse!["product"]['nutriments']['energy_100g'].toString();
        String sodium_valu= mapResponse!["product"]['nutriments']['sodium_100g'].toString();

        Globalvireables.proteins = proteins;
        Globalvireables.energy_100g = energy_100g;
        Globalvireables.fat = fat;
        Globalvireables.image = image;

        Globalvireables.sugars = sugars;
        Globalvireables.sodium_valu=sodium_valu;
        Globalvireables.carbohydrates = carbohydrates;
        print(" image :" + image + "   ");

        if (proteins.isEmpty || image.isEmpty || proteins=="null" || energy_100g=="null") {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('حساب السعرات الحرارية'),
                content: Text('لا تتوفر معلومات كافية عن هذا المنتج'),
              )
          );
        } else {
          Navigator.push(context , MaterialPageRoute(builder: (context) {
            return const macros_screen();
          }));
        }
      }
    }catch(_){
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('حساب السعرات الحرارية'),
            content: Text('لا تتوفر معلومات كافية عن هذا المنتج'),
          )
      );

    }
  }
}
