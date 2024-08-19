import 'package:auto_size_text/auto_size_text.dart';
import 'package:corelab/features/category/view/category_screen.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../../theme/light_theme.dart';
import '../../../cammon/widgets/image/my_icon.dart';
import '../../home/view/home_screen.dart';

class PagesScreen extends StatefulWidget{
  const PagesScreen({super.key});

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  final _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const HomeScreen(),
      const CategoryScreen(),
      Container(),
      Container(),
      Container(),
    ];
    return Scaffold(
      backgroundColor: backgroundAppColor,
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 28.0,
        backgroundColor: Colors.white,
          strokeColor: primaryColor,
        items: myMenus.map((menu) => CustomNavigationBarItem(
          icon: MyIcon(menu.icon, isSelected: _currentIndex == menu.index),
          title: AutoSizeText(menu.title, style: _style(_currentIndex == menu.index),),
        )).toList(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
      body: SafeArea(
        top: false,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
      ),
    );
  }

  List<CustomNavigationBarItemOptions> get myMenus => [
    CustomNavigationBarItemOptions(title: "Inicio", icon: MyIconData.home, index: 0),
    CustomNavigationBarItemOptions(title: "Categorias", icon: MyIconData.category, index: 1),
    CustomNavigationBarItemOptions(title: "Anunciar", icon: MyIconData.add, index: 2),
    CustomNavigationBarItemOptions(title: "Favoritos", icon: MyIconData.favorite, index: 3),
    CustomNavigationBarItemOptions(title: "Conta", icon: MyIconData.account, index: 4),
  ];

  _style(bool isSelected) => TextStyle(color: isSelected ? Theme.of(context).primaryColor : colorIconDisabled, fontSize: 12);
}

class CustomNavigationBarItemOptions{
  String title;
  String icon;
  int index;

  CustomNavigationBarItemOptions({required this.icon, required this.title, required this.index});
}