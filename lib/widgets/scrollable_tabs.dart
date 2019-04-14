import 'package:flutter/material.dart';
import '../pages/page.dart';

enum TabsStyle {
  iconsAndText,
  iconsOnly,
  textOnly,
}

class ScrollableTabs extends StatefulWidget {
  ScrollableTabs({
    Key key,
    this.title,
    this.initinalIndex,
    this.tabsStyle,
    this.isScrollable,
    this.floatingActionButton,
    this.bottomNavigationBar,
    @required this.pages,
  }) : super(key: key);

  final Widget title;
  final TabsStyle tabsStyle;
  final List<Page> pages;
  final initinalIndex;
  final bool isScrollable;
  final FloatingActionButton floatingActionButton;
  final BottomNavigationBar bottomNavigationBar;

  @override
  ScrollableTabsState createState() => ScrollableTabsState(
    pages: pages,
    title: title,
    initinalIndex: initinalIndex,
    tabsStyle: tabsStyle,
    isScrollable: isScrollable,
    floatingActionButton: floatingActionButton,
    bottomNavigationBar: bottomNavigationBar,
  );
}

class ScrollableTabsState extends State<ScrollableTabs> with SingleTickerProviderStateMixin {
  ScrollableTabsState({
    this.pages,
    this.title,
    this.initinalIndex,
    this.tabsStyle,
    this.isScrollable,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  TabController _controller;

  final Widget title;
  final List<Page> pages;
  final initinalIndex;
  final TabsStyle tabsStyle;
  final bool isScrollable;
  final FloatingActionButton floatingActionButton;
  final BottomNavigationBar bottomNavigationBar;

  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: initinalIndex, vsync: this, length: pages.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Decoration getIndicator() {
    if (!_customIndicator) {
      return UnderlineTabIndicator();
    }

    switch (tabsStyle) {
      case TabsStyle.iconsAndText:
        return ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          )
        );
      case TabsStyle.iconsOnly:
        return ShapeDecoration(
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const CircleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );
      case TabsStyle.textOnly:
        return ShapeDecoration(
          shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 2.0,
            ),
          ) + const StadiumBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: title,
        bottom: TabBar(
          controller: _controller,
          isScrollable: isScrollable ?? false,
          indicator: getIndicator(),
          tabs: pages.map<Tab>((Page page) {
            switch (tabsStyle) {
              case TabsStyle.iconsAndText:
                return Tab(text: page.text, icon: Icon(page.icon));
              case TabsStyle.iconsOnly:
                return Tab(icon: Icon(page.icon));
              case TabsStyle.textOnly:
                return Tab(text: page.text);
              default:
                return Tab(text: page.text);
            }
          }).toList(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: pages.map<Widget>((Page page) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Container(
              key: ObjectKey(page.icon),
              padding: const EdgeInsets.all(12.0),
              child: page.body,
            ),
          );
        }).toList(),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}