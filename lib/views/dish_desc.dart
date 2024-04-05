import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';
import '../providers/getdishprovider.dart';

class Dish_Description extends StatefulWidget {
  const Dish_Description({Key? key}) : super(key: key);

  @override
  State<Dish_Description> createState() => _Dish_DescriptionState();
}

class _Dish_DescriptionState extends State<Dish_Description> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDishProvider>(
  builder: (context, dishprovider, child) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              dishprovider.selecteddish![0]!.image ?? "",
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            top: 300,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70),
                  topLeft: Radius.circular(70),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorClass.baseColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              _counter--;
                            });
                            dishprovider.subtractDish();
                          },
                          padding: EdgeInsets.all(4),
                          minWidth: 0,
                          child: Icon(Icons.remove,
                              color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 1),
                        AnimatedOpacity(
                          opacity: _counter != -1 ? 1 : 0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            '$_counter',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 1),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              _counter++;
                            });
                            dishprovider.addDishtocart();
                            dishprovider.addtoorder([dishprovider.selecteddish]);
                          },
                          padding: EdgeInsets.all(4),
                          minWidth: 0,
                          child: Icon(Icons.add,
                              color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    dishprovider.selecteddish?[0].lable ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            color: ColorClass.baseColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Ingredients",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                 Expanded(
  child: ListView.builder(
    itemCount: dishprovider.selecteddish![0].ingredients?.length ?? 0,
    itemBuilder: (context, index) {
      return Container(
        height: 100,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/images/chef_image.png',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                dishprovider.selecteddish![0].ingredients![index],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
       
          ],
        ),
      );
    },
  ),
),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
);


  }
}
