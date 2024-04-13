import 'package:flutter/material.dart';

class MyCar extends StatelessWidget {
  const MyCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160, width: 160, child: Image.asset('assets/car.png'));
  }
}
