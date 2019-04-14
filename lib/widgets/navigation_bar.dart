import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
      _color = color,
      _title = title,
      item = BottomNavigationBarItem(
        icon: icon,
        activeIcon: activeIcon,
        title: Text(title),
        backgroundColor: color,
      ),
      controller = AnimationController(duration: kThemeAnimationDuration, vsync: vsync) {
        _animation = controller.drive(CurveTween(
          curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        ));
      }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;
}

class NavigationBar extends StatefulWidget {
  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _views;

  @override
  void initState() {
    super.initState();
    _views = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.home),
        color: Colors.indigo,
        title: 'Home',
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.explore),
        title: 'Redux',
        color: Colors.indigo,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.account_circle),
        title: 'Me',
        color: Colors.indigo,
        vsync: this,
      ),
    ];
    _views[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _views) {
      view.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar navBar = BottomNavigationBar(
      items: _views.map<BottomNavigationBarItem>((NavigationIconView view) => view.item).toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _views[_currentIndex].controller.reverse();
          _currentIndex = index;
          _views[_currentIndex].controller.forward();
        });
      },
    );
   
    return Scaffold(
      appBar: null,
      body: Center(
        child: Text('This is a NavigationBar'),
      ),
      bottomNavigationBar: navBar,
    );
  }
}