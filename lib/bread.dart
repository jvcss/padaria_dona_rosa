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
          Text(
            '$breadCount ${breadCount == 1 ? 'pão' : 'pães'}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          // Dynamically display the correct image based on the bread count
          Image.asset(
            _getBreadImage(),
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }

  // Returns the correct image asset path based on the bread count
  String _getBreadImage() {
    if (breadCount == 1) {
      return 'assets/bread.png'; // Single bread
    } else if (breadCount == 2) {
      return 'assets/basket_2bread.png'; // Basket with 2 breads
    } else if (breadCount == 3) {
      return 'assets/basket_3bread.png'; // Basket with 3 breads
    } else if (breadCount >= 4) {
      return 'assets/basket_4bread.png'; // Basket with 4 breads (or more)
    } else {
      return 'assets/bread.png'; // Default to single bread
    }
  }
}
