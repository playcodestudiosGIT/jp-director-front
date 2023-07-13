import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class SideBarProvider extends ChangeNotifier {
  static late AnimationController menuController;
  static bool isOpen = false;
  bool isAparece = true;

  setIsAparece(bool value) {
    isAparece = value;
    notifyListeners();
  }

  String _currentPage = '';

  String get currentPage {
    return _currentPage;
  }

  static Animation<double> movement = Tween<double>(begin: -160, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    isOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    isOpen = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (isOpen) ? menuController.reverse() : menuController.forward();

    isOpen = !isOpen;
  }

  void setCurrentPageUrl(String routeName) {
    _currentPage = routeName;
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        notifyListeners();
      },
    );
  }
}
