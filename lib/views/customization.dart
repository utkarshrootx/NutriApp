import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutriapp/views/dish_desc.dart';
import 'package:provider/provider.dart';
import '../constant/colors.dart';
import '../providers/getdishprovider.dart';
import 'package:badges/badges.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Customization extends StatefulWidget {
  const Customization({Key? key}) : super(key: key);

  @override
  State<Customization> createState() => _CustomizationState();
}

class _CustomizationState extends State<Customization> {
  // void initState() {
  //   super.initState();
  //   Provider.of<GetDishProvider>(context, listen: false).getDish();
  // }

  var controller = TextEditingController();
  bool _isImageVisible = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDishProvider>(
      builder: (context, dishprovider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorClass.baseColor,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  if (dishprovider.cartNumber != 0)
                    Positioned(
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          dishprovider.cartNumber.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          drawer: Drawer(
            child: Container(
              color: ColorClass.baseColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: ColorClass.baseColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              AssetImage('assets/images/chef_image.png'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Chef',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/home');
                    },
                    hoverColor: Colors.white,
                    selectedTileColor: Colors.white,
                  ),
                  ListTile(
                    leading: Icon(Icons.search, color: Colors.white),
                    title: const Text(
                      'Smart Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/smartsearch');
                    },
                    hoverColor: Colors.white,
                    selectedTileColor: Colors.white,
                  ),
                  ListTile(
                    leading: Icon(Icons.menu, color: Colors.white),
                    title: const Text(
                      'Menu',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/menu');
                    },
                    hoverColor: Colors.white,
                    selectedTileColor: Colors.white,
                  ),
                  ListTile(
                    leading: Icon(Icons.food_bank, color: Colors.white),
                    title: const Text(
                      'Food Banks',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/foodbanks');
                    },
                    hoverColor: Colors.white,
                    selectedTileColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
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
                        height: 50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Customize ",
                            style: TextStyle(
                              color: ColorClass.baseColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Plate',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            onSubmitted: (value) {
                                              setState(() {
                                                _isImageVisible = false;
                                              });
                                              dishprovider.getDish();
                                            },
                                            controller:
                                                dishprovider.diseaseController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              labelText:
                                                  'Enter Ingredients/Diseases',
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {
                                            // Add your button onPressed logic here
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'assets/images/FilterButton.png',
                                      height: 40,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  2,
                                              width: 800,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      offset: Offset(
                                                        2.0,
                                                        2.0,
                                                      ),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 5.0,
                                                    ),
                                                  ]),
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      'Filter',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      'Ingredients',
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 60,
                                                          width: 350,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child:
                                                              IntrinsicHeight(
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  dishprovider
                                                                      .keyword
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<
                                                                            Color>(
                                                                        ColorClass
                                                                            .baseColor),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    dishprovider
                                                                        .removefilter(
                                                                            dishprovider.keyword[index]);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        dishprovider
                                                                            .keyword[index],
                                                                        softWrap:
                                                                            true, // Prevent text from wrapping
                                                                        overflow:
                                                                            TextOverflow.fade, // Fade overflowed text
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: GridView.count(
                            childAspectRatio: 0.62,
                            physics:
                                NeverScrollableScrollPhysics(), // Disable grid scrolling
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(10),
                            children: List.generate(
                                // ignore: unnecessary_null_comparison
                                dishprovider.dishList != null
                                    ? dishprovider.dishList!.length
                                    : 0, (index) {
                              if (dishprovider.dishList!.isNotEmpty) {
                                  print("thisis");
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE2E3E8),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.network(
                                          dishprovider
                                                  .dishList![index].image! ??
                                              "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${dishprovider.dishList![index].lable}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorClass.baseColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Text(
                                            'Cal ${dishprovider.dishList![index].calories?.toInt()}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: ColorClass.baseColor,
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                UrlLauncher.launch(
                                                    "${dishprovider.dishList![index].url}");
                                              },
                                              child: Text(
                                                'View Recipie',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorClass.baseColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding: EdgeInsets.all(8),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                dishprovider.selectedList(
                                                    dishprovider
                                                            .dishList?[index]
                                                            .lable ??
                                                        "");
                                                Navigator.pushNamed(
                                                    context, '/dishes');
                                              },
                                              child: Text(
                                                'Ingredient',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorClass.baseColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding: EdgeInsets.all(8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                              
                                return Image.asset(
                                        'assets/images/search.png',
                                        fit: BoxFit.contain,
                                      );
                              }
                            }),
                          ),
                        ),
                      ),
                    ],
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
