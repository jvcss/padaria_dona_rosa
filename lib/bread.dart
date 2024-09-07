import 'package:flutter/material.dart';

class BreadCard extends StatelessWidget {
  final int breadCount;
  const BreadCard({super.key, required this.breadCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$breadCount pães'),
          const SizedBox(height: 10),
          Image.asset('assets/bread.png', width: 100, height: 100),
        ],
      ),
    );
  }
}