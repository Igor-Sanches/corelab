import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController implements GetxService{

  bool _loading = false;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  bool get loading => _loading;
  GlobalKey<ScaffoldState>? get scaffoldKey => _scaffoldKey;

  void setScaffoldKey(GlobalKey<ScaffoldState>? scaffoldKey) {
    _scaffoldKey = scaffoldKey;
  }

  void loadingApp(loading){
    _loading = loading;
    update();
  }

}