import 'package:flutter/material.dart';

import '../../../theme/light_theme.dart';

class MyIcon extends StatelessWidget{
  String icon;
  bool isSelected;

  MyIcon(this.icon, {super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    double _size = 30;
    if(isSelected){
      icon = '$icon-filled';
    }
    return Image.asset('$icon.png', color: isSelected ? Theme.of(context).primaryColor : colorIconDisabled, colorBlendMode: BlendMode.srcIn, width: _size, height: _size,);
  }

}

class MyIconData{
  static const String home = 'assets/icons/home';
  static const String category = 'assets/icons/category';
  static const String add = 'assets/icons/add';
  static const String favorite = 'assets/icons/favorite';
  static const String account = 'assets/icons/account';
  static const String search = 'assets/icons/search.png';
  static const String searchPage = 'assets/icons/search-page.png';
  static const String cancel = 'assets/icons/cancel';
  static const String searchQuery = 'assets/icons/search-query.png';
  static const String placeholder = '';
  static const String blankPlaceholder = '';
}