// import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class PageProvider extends ChangeNotifier {
  PageController homePageController = PageController();
  final List<String> _pages = ['home', 'ads', 'servicios', 'resultados', 'contacto'];
  int _currentIndex = 0;

  getCurrentIndex() => _currentIndex;
  setCurrentIndex(value) {
    _currentIndex = value;
  }

  int _stateIndex = 0;

  getStateIndex() => _stateIndex;

  setStateIndex(value) {
    _stateIndex = value;
  }

  createScrollController(String routeName) {
    homePageController = PageController(initialPage: getPageIndex(routeName));

    html.document.title = _pages[getPageIndex(routeName)];

    homePageController.addListener(() {
      final index = (homePageController.page ?? 0).round();

      if (index != _currentIndex) {
        html.window.history.pushState(null, 'none', '#/${_pages[index]}');
        _currentIndex = index;
        html.document.title = _pages[index];
      }
    });
  }

  int getPageIndex(String routeName) {
    return (!_pages.contains(routeName)) ? 0 : _pages.indexOf(routeName);
  }

  goTo(int index) {
    // final routeName = _pages[index];
    html.window.history.pushState(null, 'none', '#/${_pages[index]}');

    homePageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
