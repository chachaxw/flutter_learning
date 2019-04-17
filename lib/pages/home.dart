import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_image/network.dart';
import 'package:redux/redux.dart';
import 'page.dart';

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

  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh(context) async {
    StoreProvider.of<AppState>(context).dispatch(getNewsListAction);
  }

  Widget _buildDiscover(BuildContext context, List<dynamic> newsData) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _handleRefresh(context),
      color: Colors.orange,
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: newsData.length,
        itemBuilder: (BuildContext context, int index) {
          var item = newsData[index];
          var id = item['id'];
          var url = item['urlToImage'];
          var title = item['title'];
          var description = item['description'];

          var avatar = Image(
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            image: new NetworkImageWithRetry(url),
          );

          return new Card(
            key: id,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Container(
                width: 80.0,
                alignment: Alignment.center,
                child: url != null ? avatar : 
                Icon(
                  Icons.landscape,
                  color: Colors.grey,
                  size: 80.0,
                ),
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
              return vm.isLoading ? Loading(tip: 'News Coming...') : _buildDiscover(context, vm.newsList);
            },
            onInit: (Store<AppState> store) {
              StoreProvider.of<AppState>(context).dispatch(getNewsListAction(store));
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
    @required this.newsList,
    @required this.isLoading,
  });

  final List<dynamic> newsList;
  final bool isLoading;

  // This is simply a constructor method.
	// This creates a new instance of this _viewModel
	// with the proper data from the Store.
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      newsList: store.state.newsList,
      isLoading: store.state.isLoading,
    );
  }
}