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

class ScrollableTabs extends StatefulWidget {
  ScrollableTabs({ Key key, this.pages, this.title }) : super(key: key);

  final String title;
  final List<_Page> pages;

  @override
  ScrollableTabsState createState() => ScrollableTabsState(pages: pages);
}

class ScrollableTabsState extends State<ScrollableTabs> with SingleTickerProviderStateMixin {
  ScrollableTabsState({ this.pages });

  TabController _controller;
  TabsStyle _tabsStyle = TabsStyle.textOnly;

  final List<_Page> pages;
  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();

    if (pages != null) {
      _controller = TabController(vsync: this, length: pages.length);
    }
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
        title: Text(widget.title),
        bottom: pages != null ? TabBar(
          controller: _controller,
          isScrollable: false,
          indicator: getIndicator(),
          tabs: pages.map<Tab>((_Page page) {
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
        ) : null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: pages != null ? TabBarView(
        controller: _controller,
        children: pages.map<Widget>((_Page page) {
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
      ) : Container(
        alignment: Alignment.center,
        child: Text('No Data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}