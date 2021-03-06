import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_image/network.dart';
import 'package:redux/redux.dart';
import 'page.dart';

import 'package:flutter_learning/pages/news_detail.dart';
import 'package:flutter_learning/widgets/scrollable_tabs.dart';
import 'package:flutter_learning/actions/loading_actions.dart';
import 'package:flutter_learning/actions/home_actions.dart';
import 'package:flutter_learning/models/app_state.dart';
import 'package:flutter_learning/widgets/loading.dart';
import 'package:flutter_learning/routes.dart';

class HomePage extends StatefulWidget {
  HomePage({this.title}) : super(key: AppRouteKeys.homePage);

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

  _viewDetails(
    BuildContext context,
    String url,
    String title,
    String content,
    String urlToImage,
    String publishedAt,
    String source,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailPage(
        url: url,
        title: title,
        source: source,
        content: content,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
      )),
    );
  }

  Widget _buildDiscover(BuildContext context, _ViewModel vm) {
    var newsList = vm.newsList;
    var isLoading= vm.isLoading;

    if (isLoading) {
      return Loading(tip: 'News Coming...');
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => _handleRefresh(context),
      color: Colors.orange,
      child: new ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (BuildContext context, int index) {
          var item = newsList[index];
          var url = item['url'];
          var title = item['title'];
          var content = item['content'];
          var source = item['source']['name'];
          var urlToImage = item['urlToImage'];
          var description = item['description'];
          var publishedAt = item['publishedAt'];

          var thumb = urlToImage != null ? Image(
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            image: new NetworkImageWithRetry(urlToImage),
          ) : Icon(
            Icons.landscape,
            color: Colors.grey,
            size: 80.0,
          );

          return GestureDetector(
            onTap: () => _viewDetails(context, url, title, content, urlToImage, publishedAt, source),
            child: new Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: Container(
                  width: 80.0,
                  height: 80,
                  alignment: Alignment.topCenter,
                  child: thumb,
                ),
                title: Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Text(
                  description ?? '',
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
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
              return _buildDiscover(context, vm);
            },
            onInit: (Store<AppState> store) {
              StoreProvider.of<AppState>(context).dispatch(LoadingStartAction());
              StoreProvider.of<AppState>(context).dispatch(getNewsListAction);
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