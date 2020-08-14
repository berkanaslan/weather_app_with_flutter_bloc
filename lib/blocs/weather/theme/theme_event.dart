part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  final String weatherStateAbbr;

  ChangeThemeEvent({@required this.weatherStateAbbr});

  @override
  // TODO: implement props
  List<Object> get props => [weatherStateAbbr];
}
