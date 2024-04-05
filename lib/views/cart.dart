import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutriapp/constant/colors.dart';
import 'package:provider/provider.dart';

import '../providers/getdishprovider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorClass.baseColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/customizesearch");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: ColorClass.baseColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<GetDishProvider>(
        builder: (BuildContext context, cartdish, Widget? child) {
          return Center(
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
                      Container(
                        height: 450,
                        child: ListView.builder(
                          itemCount: cartdish.orderlist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 110,
                              width: 150,
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Image.network(
                                      cartdish.orderlist[index][0][0].image! ??
                                          "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Text(
                                              cartdish
                                                  .orderlist[index][0][0].lable,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            color: ColorClass.baseColor,
                                          ),
                                          Text(
                                            cartdish
                                                .orderlist[index][0][0].price
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: ColorClass.baseColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 50),
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 148, 213, 128),
                                ColorClass.baseColor
                              ],
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      cartdish.totaleamount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 90),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: const Text(
                                      'Place My Order',
                                      style: TextStyle(
                                        color: ColorClass.baseColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
