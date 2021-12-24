class DiscoverUiState {
  DiscoverUiState._();

  factory DiscoverUiState.initial() => Initial();
  factory DiscoverUiState.searchSubmitted(String search) => SearchSubmitted(search);
}

class SearchSubmitted extends DiscoverUiState {
  final String text;

  SearchSubmitted(this.text) : super._();
}

class Initial extends DiscoverUiState {
  Initial() : super._();
}
