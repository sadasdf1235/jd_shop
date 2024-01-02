import 'package:flutter/material.dart';
import 'package:jd_shop/pages/tabs/Cart.dart';
import 'package:jd_shop/pages/tabs/Category.dart';
import 'package:jd_shop/pages/tabs/Home.dart';
import 'package:jd_shop/pages/tabs/User.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _countIndex = 0;
  late var _pageController;
  final List<BottomNavigationBarItem> _itemsList = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "首页"
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: "分类",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "购物车",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: "我的",
    )
  ];
  final List<Widget> _bodysList = const [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _countIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _bodysList,
        onPageChanged: (index){
          setState(() {
            _countIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _countIndex,
        onTap: (index) {
          setState(() {
            _countIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: _itemsList,
      ),
    );
  }
}
