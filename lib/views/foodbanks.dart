import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutriapp/constant/colors.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class FoodBanks extends StatefulWidget {
  const FoodBanks({super.key});

  @override
  State<FoodBanks> createState() => _FoodBanksState();
}

class _FoodBanksState extends State<FoodBanks> {
  final List<String> foodbanks_names = <String>[
    'Regional Food Distribution Association',
    'Community Food Centres',
    'Feed Ontario'
  ];

  final List<String> foodbanks_images = <String>[
    'assets/images/1.jpg',
    'assets/images/2.png',
    'assets/images/3.png'
  ];
  final List<String> foodbanks_url = <String>[
    'https://www.foodbanksnorthwest.ca/',
    'https://cfccanada.ca/en/Ways-To-Give?gad_source=1&gclid=CjwKCAjwnv-vBhBdEiwABCYQAwq4Q-baC8TSeiY1FRlF4IztD5t2AyQae5im3braQDlmYlCp8LGIqRoCRMIQAvD_BwE',
    'https://feedontario.ca/'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/Pattern.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Center(
                    child: Text(
                      'Food Banks',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
              
                  SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorClass.lightGreen,
                                  blurRadius: 5,
                                  offset: Offset(0, 2.5),
                                )
                              ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 160,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      '${foodbanks_names[index]}',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                   UrlLauncher.launch("${foodbanks_url[index]}" );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorClass.baseColor,
                                      padding: EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      minimumSize: Size(0, 0),
                                      alignment: Alignment.center,
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        height: 30,
                                        width: 90,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Donate',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 130,
                                      child: Image.asset(
                                        '${foodbanks_images[index]}',
                                        fit: BoxFit.fill,
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
