import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/theme/theme_bloc.dart';
import 'package:news_bloc/theme/theme_state.dart';
import 'package:news_bloc/utils/routes/app_routes.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            routes: appRoutes,
            title: 'News App',
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
