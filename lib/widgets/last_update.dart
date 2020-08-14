import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/theme/theme_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/weather_bloc.dart';

class LastUpdateWidget extends StatefulWidget {
  @override
  _LastUpdateWidgetState createState() => _LastUpdateWidgetState();
}

class _LastUpdateWidgetState extends State<LastUpdateWidget> {
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    @override
    void dispose() {
      _weatherBloc.close();
      super.dispose();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
            cubit: _weatherBloc,
            builder: (context, WeatherState state) {
              var time = (state as WeatherLoadedState).weather.time.toLocal();
              return BlocBuilder(
                cubit: BlocProvider.of<ThemeBloc>(context),
                builder: (context, state) => Text(
                  "Last update: " + TimeOfDay.fromDateTime(time).format(context),
                  style: TextStyle(color: (state as ApplicationThemeState).textColor),
                ),
              );
            }),
      ),
    );
  }
}
