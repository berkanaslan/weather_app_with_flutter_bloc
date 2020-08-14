import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  GradientBackground({@required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color[800],
            color[600],
            color[400],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
