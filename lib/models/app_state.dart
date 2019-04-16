class AppState {
  final int count;
  final bool isLoading;
  final List<dynamic> newsList;

  AppState({this.count = 0, this.isLoading = false, this.newsList});

  AppState copyWith({int count, bool isLoading, List<dynamic> newsList}) {
    return new AppState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
      newsList: newsList ?? this.newsList,
    );
  }

  @override
	String toString() {
		return 'AppState{isLoading: $isLoading, count: $count}';
	}
}