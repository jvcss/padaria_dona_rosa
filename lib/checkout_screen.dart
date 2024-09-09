import 'package:flutter/material.dart';
import 'package:padaria_dona_rosa/discount_calendar_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;

  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double discount = 0; // Initial discount

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for pulsing effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    )..repeat(reverse: true); // Repeat animation to create a pulse
    // Scale animation between 0.9 and 1.1 to make it pulse
    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to show the calendar pop-up
  void _showDiscountCalendar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DiscountCalendarDialog(); // Use the new dialog widget
      },
    );
  }

  // // Widget for building the custom discount calendar
  // Widget _buildDiscountCalendar() {
  //   final DateTime now = DateTime.now();
  //   //final int currentDayOfWeek = now.weekday;
  //   // Current day of the week (1 = Monday, 7 = Sunday)

  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       itemCount: 7, // Let's assume we're showing one week (7 days)
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 7, // 7 columns for 7 days of the week
  //       ),
  //       itemBuilder: (context, index) {
  //         DateTime day = now.add(Duration(days: index)); // Calculate each day in the week

  //         // Define the color of each day based on its relative position
  //         Color dayColor;
  //         if (index == 0) {
  //           dayColor = Colors.red; // Today: no discount
  //         } else if (index > 0 && index <= 5) {
  //           dayColor = Colors.green.withOpacity(index * 0.2); // Gradually more green up to 5th day
  //         } else {
  //           dayColor = Colors.green; // After 5 days, fully green
  //         }

  //         return Container(
  //           margin: const EdgeInsets.all(4),
  //           decoration: BoxDecoration(
  //             color: dayColor,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Center(
  //             child: Text(
  //               DateFormat.E().format(day), // Display the day name (Mon, Tue, etc.)
  //               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Total Amount

              Container(
                alignment: Alignment.center,
                height: 100,
                child: GestureDetector(
                  onTap: _showDiscountCalendar,
                  child: Stack(
                    alignment: Alignment.topRight,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                        child: Text(
                          'R\$ ${(widget.totalAmount * (1 - discount / 100)).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Discount Badge with Animation
                      Positioned(
                        top: 0, // Adjust to move the badge upwards
                        right: 0, // Adjust to move the badge to the right
                        child: AnimatedBuilder(
                          animation: _animationController, // Use AnimatedBuilder to listen for animation changes
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _animation.value, // Use the animation value to scale the badge
                              child: child,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '${discount.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // QR Code or Card Placeholder
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  // Placeholder for QR Code or Card image
                  child: Icon(Icons.qr_code, size: 80, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),

              // Payment options
              Column(
                children: [
                  // Pix Payment Button
                  SizedBox(
                    width: double.infinity, // Make button take full width
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for Pix payment
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('PIX', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Cartao Payment Button
                  SizedBox(
                    width: double.infinity, // Make button take full width
                    child: OutlinedButton(
                      onPressed: () {
                        // Action for Cartao payment
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Cartão', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Local Payment Button
                  SizedBox(
                    width: double.infinity, // Make button take full width
                    child: OutlinedButton(
                      onPressed: () {
                        // Action for Local payment
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15), // Adjust padding as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Retirada Local', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
