// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/news_bloc.dart';
// import '../bloc/news_event.dart';
// import '../bloc/news_state.dart';
// import '../theme/theme_bloc.dart';
// import '../theme/theme_event.dart';
// import '../utils/helper/api_helper.dart';
//
// class NewsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("News App"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.brightness_6),
//             onPressed: () {
//               context.read<ThemeBloc>().add(ToggleTheme());
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider(
//         create: (_) => NewsBloc(ApiHelper())..add(FetchNews()),
//         child: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (state is NewsLoading) {
//               return  const Center(child: CircularProgressIndicator());
//             } else if (state is NewsLoaded) {
//               final articles = state.news.articles;
//               return ListView.builder(
//                 itemCount: articles?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final article = articles![index];
//                   return Card(
//                     margin: const EdgeInsets.all(8.0),
//                     child: ListTile(
//                       leading: article.urlToImage != null
//                           ? Image.network(article.urlToImage!, width: 100)
//                           : null,
//                       title: Text(article.title ?? "No Title"),
//                       subtitle: Text(article.description ?? "No Description"),
//                     ),
//                   );
//                 },
//               );
//             } else if (state is NewsError) {
//               return Center(child: Text("Error: ${state.error}"));
//             }
//             return const Center(child: Text("No Data"));
//           },
//         ),
//       ),
//     );
//   }
// }
//
/*****/
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/news_bloc.dart';
// import '../bloc/news_event.dart';
// import '../bloc/news_state.dart';
// import '../theme/theme_bloc.dart';
// import '../theme/theme_event.dart';
// import '../utils/helper/api_helper.dart';
// import 'detail_screen.dart';
//
// class NewsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("News App"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.brightness_6),
//             onPressed: () {
//               context.read<ThemeBloc>().add(ToggleTheme());
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider(
//         create: (_) => NewsBloc(ApiHelper())..add(FetchNews()),
//         child: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (state is NewsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is NewsLoaded) {
//               final articles = state.news.articles;
//               return ListView.builder(
//                 itemCount: articles?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final article = articles![index];
//                   return Card(
//                     shadowColor: Colors.white70,
//                     //elevation: 0,
//                     //
//                     // color: Colors.white,
//                     shape: Border.all(),
//                     margin: const EdgeInsets.all(8.0),
//                     child: ListTile(
//                       leading: article.urlToImage != null
//                           ? Image.network(article.urlToImage!, width: 80, fit: BoxFit.cover)
//                           : Image.asset('assets/image/news.jpg', width: 80, fit: BoxFit.cover),
//                       title: Text(
//                         style: Theme.of(context).textTheme.bodyLarge,
//                         //
//                         article.title ?? "No Title",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NewsDetailScreen(article: article),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             } else if (state is NewsError) {
//               return Center(child: Text("Error: ${state.error}"));
//             }
//             return const Center(child: Text("No Data"));
//           },
//         ),
//       ),
//     );
//   }
// }
/*=----------*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../theme/theme_bloc.dart';
import '../theme/theme_event.dart';
import '../utils/helper/api_helper.dart';
import '../utils/helper/database_helper.dart';
import 'detail_screen.dart';

class NewsScreen extends StatelessWidget {
  GlobalKey repaintKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
      ),
      body: RepaintBoundary(
        key: repaintKey,
        child: BlocProvider(
          create: (_) =>
              NewsBloc(ApiHelper(), DatabaseHelper())..add(FetchNews()),
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NewsLoaded) {
                final articles = state.news.articles;
                return ListView.builder(
                  itemCount: articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    final article = articles![index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: article.urlToImage != null
                            ? CachedNetworkImage(imageUrl: article.urlToImage ?? "",
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),)
                        // Image.network(article.urlToImage!,
                        //         width: 80, fit: BoxFit.cover)
                            : Image.asset('assets/image/news.jpg',
                                width: 80, fit: BoxFit.cover),
                        title: Text(
                          article.title ?? "No Title",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.save_alt),
                          onPressed: () {

                            // Share.share('${article.title}\n\nRead more: ${article.urlToImage ?? ""}');
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailScreen(article: article),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
                //
              } else if (state is NewsError) {
                return Center(child: Text("Error: ${state.error}"));
              }
              return const Center(child: Text("No Data"));
            },
          ),
        ),
      ),
    );
  }
}
/*=----------*/
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/news_bloc.dart';
// import '../bloc/news_event.dart';
// import '../bloc/news_state.dart';
// import '../theme/theme_bloc.dart';
// import '../theme/theme_event.dart';
// import '../utils/helper/api_helper.dart';
// import '../utils/helper/database_helper.dart';
// import 'detail_screen.dart';
//
// class NewsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("News App"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.brightness_6),
//             onPressed: () {
//               context.read<ThemeBloc>().add(ToggleTheme());
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider(
//         create: (_) => NewsBloc(ApiHelper(), DatabaseHelper())..add(FetchNews()),
//         child: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (state is NewsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is NewsLoaded) {
//               final articles = state.news.articles;
//               return ListView.builder(
//                 itemCount: articles?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final article = articles![index];
//                   return Card(
//                     margin: const EdgeInsets.all(8.0),
//                     child: ListTile(
//                       leading: article.urlToImage != null
//                           ? Image.file(File(article.urlToImage!), width: 80, fit: BoxFit.cover)
//                           : Image.asset('assets/image/news.jpg', width: 80, fit: BoxFit.cover),
//                       title: Text(
//                         article.title ?? "No Title",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NewsDetailScreen(article: article),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             } else if (state is NewsError) {
//               return Center(child: Text("Error: ${state.error}"));
//             }
//             return const Center(child: Text("No Data"));
//           },
//         ),
//       ),
//     );
//   }
// }