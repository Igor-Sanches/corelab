import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class Helpers{
  static Widget loading({double size = 90, Color? colorOne, Color? colorTwo, int? animationNumber}) {
    colorOne ??= Theme.of(Get.context!).primaryColor;
    colorTwo ??= Colors.black38;
    int type = animationNumber??Random().nextInt(20) + 1;
    Widget widget = Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: colorOne,
        rightDotColor: colorTwo,
        size: size,
      ),
    );
    switch(type){
      case 1:
        widget = Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: colorOne,
            rightDotColor: colorTwo,
            size: size,
          ),
        );
        break;
      case 2:
        widget = Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            size: size, color: colorOne,
          ),
        );
        break;
      case 3:
        widget = Center(
          child: LoadingAnimationWidget.threeRotatingDots(
            size: size, color: colorOne,
          ),
        );
        break;
      case 4:
        widget = Center(
          child: LoadingAnimationWidget.twoRotatingArc(
            size: size, color: colorOne,
          ),
        );
        break;
      case 5:
        widget = Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            size: size, color: colorOne,
          ),
        );
        break;
      case 6:
        widget = Center(
          child: LoadingAnimationWidget.hexagonDots(
            size: size, color: colorOne,
          ),
        );
        break;
      case 7:
        widget = Center(
          child: LoadingAnimationWidget.fallingDot(
            size: size, color: colorOne,
          ),
        );
        break;
      case 8:
        widget = Center(
          child: LoadingAnimationWidget.dotsTriangle(
            size: size, color: colorOne,
          ),
        );
        break;
      case 9:
        widget = Center(
          child: LoadingAnimationWidget.discreteCircle(
            size: size, color: colorOne,
          ),
        );
        break;
      case 10:
        widget = Center(
          child: LoadingAnimationWidget.bouncingBall(
            size: size, color: colorOne,
          ),
        );
        break;
      case 11:
        widget = Center(
          child: LoadingAnimationWidget.beat(
            size: size, color: colorOne,
          ),
        );
        break;
      case 12:
        widget = Center(
          child: LoadingAnimationWidget.flickr(
            size: size, leftDotColor: colorOne, rightDotColor: colorTwo,
          ),
        );
        break;
      case 13:
        widget = Center(
          child: LoadingAnimationWidget.halfTriangleDot(
            size: size, color: colorOne,
          ),
        );
        break;
      case 14:
        widget = Center(
          child: LoadingAnimationWidget.horizontalRotatingDots(
            size: size, color: colorOne,
          ),
        );
        break;
      case 15:
        widget = Center(
          child: LoadingAnimationWidget.inkDrop(
            size: size, color: colorOne,
          ),
        );
        break;
      case 16:
        widget = Center(
          child: LoadingAnimationWidget.newtonCradle(
            size: size, color: colorOne,
          ),
        );
        break;
      case 17:
        widget = Center(
          child: LoadingAnimationWidget.prograssiveDots(
            size: size, color: colorOne,
          ),
        );
        break;
      case 18:
        widget = Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            size: size, color: colorOne,
          ),
        );
        break;
      case 19:
        widget = Center(
          child: LoadingAnimationWidget.stretchedDots(
            size: size, color: colorOne,
          ),
        );
        break;
      case 20:
        widget = Center(
          child: LoadingAnimationWidget.waveDots(
            size: size, color: colorOne,
          ),
        );
        break;
    }

    return widget;
  }


}