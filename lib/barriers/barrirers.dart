import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double size;
  MyBarrier({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6C00FF), 
            Color(0xFFFF00E0), 
            Color(0xFF00E0FF), 
          ],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 10, color: Color(0xFF6C00FF)), 
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00E0FF).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
