import 'package:flutter/material.dart';

enum TabsStyle {
  iconsAndText,
  iconsOnly,
  textOnly,
}

class _Page {
  const _Page({ this.icon, this.text, this.body });
  final IconData icon;
  final String text;
  final Widget body;
}

const List<_Page> _allPages = <_Page>[
  _Page(icon: Icons.grade, text: 'Favorite'),
  _Page(icon: Icons.sentiment_very_satisfied, text: 'Discover'),
  _Page(icon: Icons.grain, text: 'Hot'),
];

class ScrollableTabs extends StatefulWidget {

  @override
  ScrollableTabsState createState() => ScrollableTabsState();
}

class ScrollableTabsState extends State<ScrollableTabs> with SingleTickerProviderStateMixin {
  TabController _controller;
  TabsStyle _tabsStyle = TabsStyle.iconsAndText;
  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();
  }

  Decoration getIndicator() {
    if (!_customIndicator) {
      return UnderlineTabIndicator();
    }

    switch (_tabsStyle) {
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
              width: 4.0,
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
              width: 4.0,
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
    final Color iconColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: _allPages.map<Tab>((_Page page) {
            assert(_tabsStyle != null);
            switch (_tabsStyle) {
              case TabsStyle.iconsAndText:
                return Tab(text: page.text, icon: Icon(page.icon));
              case TabsStyle.iconsOnly:
                return Tab(icon: Icon(page.icon));
              case TabsStyle.textOnly:
                return Tab(text: page.text);
            }
            return null;
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _allPages.map<Widget>((_Page page) {
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
    );
  }
}