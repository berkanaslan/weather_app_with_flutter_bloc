part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ApplicationThemeState extends ThemeState {
  final ThemeData themeData;
  final MaterialColor bgColor;
  final Color textColor;

  ApplicationThemeState({@required this.themeData, this.bgColor, this.textColor});

  @override
  List<Object> get props => [themeData, bgColor, textColor];
}
