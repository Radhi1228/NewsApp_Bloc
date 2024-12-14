import '../model/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsModel news;

  NewsLoaded(this.news);
}

class NewsError extends NewsState {
  final String error;

  NewsError(this.error);
}
