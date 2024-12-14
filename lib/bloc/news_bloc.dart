// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../utils/helper/api_helper.dart';
// import 'news_event.dart';
// import 'news_state.dart';
//
// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final ApiHelper apiHelper;
//
//   NewsBloc(this.apiHelper) : super(NewsInitial()) {
//     on<FetchNews>((event, emit) async {
//       emit(NewsLoading());
//       try {
//         final news = await apiHelper.fetchTopHeadlines(
//           country: event.country,
//           category: event.category,
//         );
//         emit(NewsLoaded(news));
//       } catch (e) {
//         emit(NewsError(e.toString()));
//       }
//     });
//   }
// }
/*------------------*/
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/news_model.dart';
import '../utils/helper/api_helper.dart';
import '../utils/helper/database_helper.dart' ;
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiHelper apiHelper;
  final DatabaseHelper databaseHelper;

  NewsBloc(this.apiHelper, this.databaseHelper) : super(NewsLoading()) {
    on<FetchNews>(_onFetchNews);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      if (await _hasInternet()) {
        final news = await apiHelper.fetchTopHeadlines();
        await databaseHelper.clearNews();
        for (var article in news.articles ?? []) {
          await databaseHelper.insertNews(article);
        }
        emit(NewsLoaded(news));
      } else {
        final offlineNews = await databaseHelper.fetchNews();
        emit(NewsLoaded(NewsModel(articles: offlineNews)));
      }
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
// import 'dart:io';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../model/news_model.dart';
// import '../utils/helper/api_helper.dart';
// import '../utils/helper/database_helper.dart';
// import 'news_event.dart';
// import 'news_state.dart';
//
// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final ApiHelper apiHelper;
//   final DatabaseHelper databaseHelper;
//
//   NewsBloc(this.apiHelper, this.databaseHelper) : super(NewsLoading()) {
//     on<FetchNews>(_onFetchNews);
//   }
//
//   Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
//     emit(NewsLoading());
//     try {
//       if (await _hasInternet()) {
//         // Fetch news from API
//         final news = await apiHelper.fetchTopHeadlines();
//         await databaseHelper.clearNews(); // Clear old news
//         for (var article in news.articles ?? []) {
//           await databaseHelper.insertNews(article); // Save each article with image locally
//         }
//         emit(NewsLoaded(news));
//       } else {
//         // Fetch offline news
//         final offlineNews = await databaseHelper.fetchNews();
//         emit(NewsLoaded(NewsModel(articles: offlineNews)));
//       }
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }
//
//   Future<bool> _hasInternet() async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       return false;
//     }
//   }
// }
