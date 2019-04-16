import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'dart:async';
import 'page.dart';

import 'package:flutter_learning/services/api_service.dart';
import 'package:flutter_learning/widgets/scrollable_tabs.dart';
import 'package:flutter_learning/actions/home_actions.dart';
import 'package:flutter_learning/models/app_state.dart';
import 'package:flutter_learning/widgets/loading.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageState();

  bool loading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();

  @override
  void initState() {
    super.initState();
  }

  _handleRefresh() {
    print('Refresh');
  }

  Widget _buildDiscover(BuildContext context, List<dynamic> newsData) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      color: Colors.orange,
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: newsData != null ? newsData.length : 0,
        itemBuilder: (BuildContext context, int index) {
          var item = newsData[index];
          var id = item['id'];
          var url = item['urlToImage'];
          var title = item['title'];
          var description = item['description'];

          return new Card(
            key: id,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: url != null ? Image.network(
                url,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ) : Icon(
                Icons.landscape,
                color: Colors.grey,
                size: 80.0,
              ),
              title: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                description,
                maxLines: 3,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager State] build and loading status $loading');

    return new ScrollableTabs(
      key: _homePageKey,
      title: Text('News'),
      initinalIndex: 1,
      tabsStyle: TabsStyle.iconsOnly,
      pages: [
        Page(
          icon: Icons.favorite,
          text: 'Favorite',
          body: Text('Favorite News'),
        ),
        Page(
          icon: Icons.explore,
          text: 'Discover',
          body: StoreConnector<AppState, _ViewModel>(
            converter: _ViewModel.fromStore,
            builder: (context, _ViewModel vm) {
              return _buildDiscover(context, vm.newsList);
            },
          ),
        ),
        Page(
          icon: Icons.grain,
          text: 'Hot',
          body: Text('Hot'),
        ),
      ],
    );
  }
}

class _ViewModel {
  _ViewModel({
    @required this.newsList
  });

  final List<dynamic> newsList;

  // This is simply a constructor method.
	// This creates a new instance of this _viewModel
	// with the proper data from the Store.
	//
	// This is a very simple example, but it lets our
	// actual counter widget do things like call 'vm.count'
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(newsList: store.state.newsList);
  }
}