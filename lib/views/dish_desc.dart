import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../providers/getdishprovider.dart';

class Dish_Description extends StatefulWidget {
  const Dish_Description({super.key});

  @override
  State<Dish_Description> createState() => _Dish_DescriptionState();
}

class _Dish_DescriptionState extends State<Dish_Description> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDishProvider>(
  builder: (context, dishprovider, child) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: ColorClass.lightGreen),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.dehaze_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorClass.baseColor,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(14),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 200,
                      left: 0,
                      right: 0, child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            topLeft: Radius.circular(100),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorClass.baseColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            onPressed: _decrementCounter,
                                            child: Icon(Icons.remove, color: Colors.white),
                                          ),
                                          SizedBox(width: 10.0),
                                          AnimatedOpacity(
                                            opacity: _counter != 1 ? 1 : 0,
                                            duration: Duration(milliseconds: 500),
                                            child: Text(
                                              '$_counter',
                                              style: TextStyle(fontSize: 20, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          MaterialButton(
                                            onPressed: _incrementCounter,
                                            child: Icon(Icons.add, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 50,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dishprovider.selecteddish?[0].recipe!.label ?? "",
                                  style: TextStyle(
                                    color: ColorClass.baseColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text(
                                  "Precision nutrition, personalized plates—your recipe for a healthier life. Precision nutrition, personalized plates—your recipe for a healthier life. Precision nutrition, personalized plates—your recipe for a healthier life. ",
                                  overflow: TextOverflow.visible,
                                  maxLines: 8,
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Row(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.star, color: ColorClass.baseColor,
                                  size: 18,
                                ),
                                SizedBox(width: 15,),
                                Text("4.5",
                                  style: TextStyle(fontSize: 15, color: ColorClass.baseColor),),
                                Spacer(),
                                Icon(
                                  Icons.local_fire_department_rounded, color: ColorClass.baseColor,
                                  size: 18,
                                ),
                                SizedBox(width: 15,),
                                Text(dishprovider.dishList?[0].recipe!.calories.toString() ?? "",
                                  style: TextStyle(fontSize: 15, color: ColorClass.baseColor),),
                                Spacer()
                              ],
                            ),
                            SizedBox(height: 150),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 18),),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorClass.baseColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Container(
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            topLeft: Radius.circular(100),
                          ),
                          ),
                          height: 200,
                          child: Image.network(
                            dishprovider.selecteddish![0].recipe!.image ?? "",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
 }
}