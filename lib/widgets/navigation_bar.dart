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

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;

    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light ?
        themeData.primaryColor : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key, this.appBar, this.body, this.floatingActionButton}) : super(key: key);

  final Widget appBar;
  final Widget body;
  final FloatingActionButton floatingActionButton;

  @override
  NavigationBarState createState() => NavigationBarState(
    appBar: appBar,
    body: body,
    floatingActionButton: floatingActionButton
  );
}

class NavigationBarState extends State<NavigationBar> with TickerProviderStateMixin {
  NavigationBarState({this.appBar, this.body, this.floatingActionButton});

  int _currentIndex = 0;
  final Widget appBar;
  final Widget body;
  final FloatingActionButton floatingActionButton;
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
      appBar: appBar,
      body: body,
      bottomNavigationBar: navBar,
      floatingActionButton: floatingActionButton,
    );
  }
}