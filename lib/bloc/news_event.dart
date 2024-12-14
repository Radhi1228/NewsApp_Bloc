abstract class NewsEvent {}

//class FetchNews extends NewsEvent {}

class FetchNews extends NewsEvent {
  final String country;
  final String category;

  FetchNews({this.country = "us", this.category = "business"});
}