

class HomeState {
  List<dynamic>  newsList;

  HomeState({ this.newsList });

  HomeState copyWidth({ List<dynamic> newsList}) {
    return new HomeState(
      newsList: newsList ?? this.newsList,
    );
  }

  @override
	String toString() {
		return 'HomeState{newsList: ${newsList.length}';
	}
}