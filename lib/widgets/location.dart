import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/theme/theme_bloc.dart';

class LocationWidget extends StatelessWidget {
  final String selectedLoctaion;

  LocationWidget({@required this.selectedLoctaion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          cubit: BlocProvider.of<ThemeBloc>(context),
          builder: (context, state) => Text(
            "${selectedLoctaion}",
            style: TextStyle(
                color: (state as ApplicationThemeState).textColor,
                fontSize: 36,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
