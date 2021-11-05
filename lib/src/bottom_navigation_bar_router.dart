import 'dart:collection';

import 'package:flutter/material.dart';

import 'bottom_navigator.dart';

class BottomNavigationBarRouter extends StatefulWidget {
  final List<BottomNavigator> navigators;
  final BottomNavigationBar bottomNavigationBar;
  BottomNavigationBarRouter({
    Key? key,
    required this.navigators,
    required this.bottomNavigationBar,
  })  : assert(navigators.length == bottomNavigationBar.items.length),
        super(key: key);

  @override
  State<BottomNavigationBarRouter> createState() =>
      _BottomNavigationBarRouterState();
}

class _BottomNavigationBarRouterState extends State<BottomNavigationBarRouter> {
  late int _currentIndex = widget.bottomNavigationBar.currentIndex;
  final Queue<int> _stack = Queue();
  @override
  Widget build(BuildContext context) {
    final _bottomNavigationBar = widget.bottomNavigationBar;
    final _navigators = widget.navigators;
    final _navigator = _navigators[_currentIndex];
    final _navigatorKey = _navigator.navigatorKey;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (_navigatorKey.currentState?.canPop() ?? true) {
            _navigatorKey.currentState?.pop();
          } else if (_stack.isNotEmpty) {
            setState(() => _currentIndex = _stack.removeLast());
          }
          return Future.value(false);
        },
        child: IndexedStack(
          children: _navigators,
          index: _currentIndex,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBar.items,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex == index) {
            _navigatorKey.currentState?.popUntil((route) => route.isFirst);
          } else {
            if (!_stack.contains(_currentIndex)) {
              _stack.add(_currentIndex);
            }
          }
          setState(() => _currentIndex = index);
          _bottomNavigationBar.onTap?.call(index);
        },
        backgroundColor: _bottomNavigationBar.backgroundColor,
        elevation: _bottomNavigationBar.elevation,
        enableFeedback: _bottomNavigationBar.enableFeedback,
        fixedColor: _bottomNavigationBar.fixedColor,
        iconSize: _bottomNavigationBar.iconSize,
        key: _bottomNavigationBar.key,
        landscapeLayout: _bottomNavigationBar.landscapeLayout,
        mouseCursor: _bottomNavigationBar.mouseCursor,
        selectedFontSize: _bottomNavigationBar.selectedFontSize,
        selectedIconTheme: _bottomNavigationBar.selectedIconTheme,
        selectedItemColor: _bottomNavigationBar.selectedItemColor,
        selectedLabelStyle: _bottomNavigationBar.selectedLabelStyle,
        showSelectedLabels: _bottomNavigationBar.showSelectedLabels,
        showUnselectedLabels: _bottomNavigationBar.showUnselectedLabels,
        type: _bottomNavigationBar.type,
        unselectedFontSize: _bottomNavigationBar.unselectedFontSize,
        unselectedIconTheme: _bottomNavigationBar.unselectedIconTheme,
        unselectedItemColor: _bottomNavigationBar.unselectedItemColor,
        unselectedLabelStyle: _bottomNavigationBar.unselectedLabelStyle,
      ),
    );
  }
}
