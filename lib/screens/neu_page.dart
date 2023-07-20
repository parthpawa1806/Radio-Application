import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final child;
  const NeuBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(child: child),
      decoration: BoxDecoration(
        color: const Color(0xffFFE4A7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          // darker shadow on the bottom right
          BoxShadow(
            color: Color(0xffFFE4A7),
            blurRadius: 15,
            offset: Offset(5, 5),
          ),

          // lighter shadow on the top left
          BoxShadow(
            color: Color(0xffFFE4A7),
            blurRadius: 15,
            offset: Offset(-5, -5),
          ),
        ],
      ),
    );
  }
}