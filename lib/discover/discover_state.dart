class DiscoverUiState {
  DiscoverUiState._();

  factory DiscoverUiState.initial() => Initial();
  factory DiscoverUiState.searchSubmitted(String search) => SearchSubmitted(search);
  factory DiscoverUiState.fetchingSection(Map<String, dynamic> filters) => FetchingSection(filters);
}

class SearchSubmitted extends DiscoverUiState {
  final String text;

  SearchSubmitted(this.text) : super._();
}

class FetchingSection extends DiscoverUiState {
  final Map<String, dynamic> filters;

  FetchingSection(this.filters) : super._();
}

class Initial extends DiscoverUiState {
  Initial() : super._();
}
