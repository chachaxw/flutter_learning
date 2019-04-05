import 'package:flutter/material.dart';

enum TabsStyle {
  iconsAndText,
  iconsOnly,
  textOnly,
}

class _Page {
  const _Page({ this.icon, this.text});
  final IconData icon;
  final String text;
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
  TabsStyle tabsStyle = TabsStyle.iconsAndText;
  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}