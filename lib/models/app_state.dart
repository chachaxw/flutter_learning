class AppState {
  final int count;
  final bool isLoading;

  AppState({this.count = 0, this.isLoading = false});

  AppState copyWith({ int count, bool isLoading }) {
    return new AppState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
	String toString() {
		return 'AppState{isLoading: $isLoading, count: $count}';
	}
}