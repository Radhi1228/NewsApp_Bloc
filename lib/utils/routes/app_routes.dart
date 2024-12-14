import 'package:flutter/cupertino.dart';
import 'package:news_bloc/screen/news_screen.dart';
import 'package:news_bloc/screen/splash_screen.dart';
import '../../screen/detail_screen.dart';

Map<String,WidgetBuilder> appRoutes = {
  "/" : (c1) => const SplashScreen(),
  "/news" : (c1) => NewsScreen(),
 // "/detail" : (c1) => NewsDetailScreen(article: ,),
};