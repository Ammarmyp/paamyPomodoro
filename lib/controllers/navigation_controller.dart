import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Observable variable for the current index
  var currentIndex = 0.obs;
  final navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Method to change the current index
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
