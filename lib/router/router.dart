import 'package:flutter/material.dart';

import 'package:jd_shop/pages/ProductList.dart';
import '../pages/Search.dart';
import '../pages/tabs/tabs.dart';

final routes = {
  '/': (context) => const Tabs(),
  '/productList': (context,{arguments})=> ProductListPage(arguments: arguments,),
  '/search': (context) => const Search(),
};
var onGenerateRoute = (RouteSettings settings) {
      // 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
