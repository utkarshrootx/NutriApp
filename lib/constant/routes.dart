
import 'package:flutter/cupertino.dart';
import 'package:nutriapp/views/customization.dart';
import 'package:nutriapp/views/dish_desc.dart';
import 'package:nutriapp/views/home.dart';
import 'package:nutriapp/views/smartsearch.dart';

Map<String, WidgetBuilder> routes = {
  "/home": (context) => Home(),
  "/customizesearch":(context) => Customization(),
  "/smartsearch":(context) => const SmartSearch(),
  "/dishes":(context) => Dish_Description()
};
