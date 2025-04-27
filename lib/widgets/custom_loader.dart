import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color color;

  const CustomLoader({
    Key? key,
    this.size = 50.0,
    this.color = const Color(0xff5EC401), // Default green
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: color,
      size: size,
    );
  }
}
