import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magic/src/repository/shared_preference.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferenceRepo sharedPreferenceRepo;
  ThemeCubit({
    required this.sharedPreferenceRepo,
  }) : super(ThemeInitial());

  Future<void> decideOnTheme() async {
    try {
      int currentTheme = await sharedPreferenceRepo.getThemeValue();
      emit(ThemeLoaded(theme: currentTheme));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> switchToLightMode() async {
    try {
      sharedPreferenceRepo.saveThemeValue(0);
      emit(const ThemeLoaded(theme: 0));
    } catch (e) {
      throw Exception(e);
    }
    emit(const ThemeLoaded(theme: 0));
  }

  Future<void> switchToDarkMode() async {
    try {
      sharedPreferenceRepo.saveThemeValue(1);
      emit(const ThemeLoaded(theme: 1));
    } catch (e) {
      throw Exception(e);
    }
    emit(const ThemeLoaded(theme: 1));
  }

  Future<void> toggleTheme() async {
    try {
      int currentTheme = await sharedPreferenceRepo.getThemeValue();
      if (currentTheme == 0) {
        await sharedPreferenceRepo.saveThemeValue(1);
        emit(const ThemeLoaded(theme: 1));
      } else {
        await sharedPreferenceRepo.saveThemeValue(0);
        emit(const ThemeLoaded(theme: 0));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
