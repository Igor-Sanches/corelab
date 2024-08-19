import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cammon/widgets/refresh/custom_refresh_widget.dart';
import '../../helper/helpers.dart';
import '../../theme/light_theme.dart';
import '../controller/root_controller.dart';

class ApplicationScreen extends StatefulWidget{
  final Widget child;
  Future<bool> Function()? onWillPop;
  Color? backgroundColor;
  Widget? bottomNavigationBar;
  GlobalKey<ScaffoldState>? scaffoldKey;
  bool? backButton;
  RefreshCallback? onRefresh;
  bool noLoading;

  ApplicationScreen({
    super.key,
    required this.child,
    this.onRefresh,
    this.bottomNavigationBar,
    this.onWillPop,
    this.backgroundColor,
    this.scaffoldKey,
    this.backButton = false,
    this.noLoading = false
  });

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> with WidgetsBindingObserver{

  @override
  void initState() {
    Get.find<RootController>().setScaffoldKey(widget.scaffoldKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller){

      return WillPopScope(
        onWillPop: () async{
          if(!controller.loading && widget.onWillPop != null){
            return await widget.onWillPop!();
          }
          return !controller.loading;
        },
        child: Stack(children: [
          Scaffold(
            key: widget.scaffoldKey,
            bottomNavigationBar: widget.bottomNavigationBar,
            backgroundColor: widget.backgroundColor ?? backgroundAppColor,
            body: widget.onRefresh == null ? widget.child : CustomRefreshWidget(
              child: widget.child,
              onRefresh: ()async{
                await widget.onRefresh!();
              },
            ),
          ),
          if(controller.loading && !widget.noLoading)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.0,
                        )
                    ),
                    child: Helpers.loading()
                ),
              ),
            )
        ],),
      );
    },);
  }

}