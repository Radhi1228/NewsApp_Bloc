import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/theme/theme_event.dart';
import 'package:news_bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleTheme>((event, emit) {
      if (state is LightThemeState) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}
