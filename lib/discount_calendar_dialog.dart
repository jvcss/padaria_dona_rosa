// New widget for the Discount Calendar
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiscountCalendarDialog extends StatefulWidget {
  const DiscountCalendarDialog({super.key});

  @override
  DiscountCalendarDialogState createState() => DiscountCalendarDialogState();
}

class DiscountCalendarDialogState extends State<DiscountCalendarDialog> with TickerProviderStateMixin {
  late AnimationController _calendarAnimationController;

  @override
  void initState() {
    super.initState();
    _calendarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward(); // Start the animation when the dialog opens
  }

  @override
  void dispose() {
    _calendarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Seu desconto diário',
        textAlign: TextAlign.center,
      ),
      content: _buildAnimatedCalendar(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }

  // Build the calendar with animations for each day
  Widget _buildAnimatedCalendar() {
    final DateTime now = DateTime.now();
    return SizedBox(
      width: double.maxFinite,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 7,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 7 days in a week
        ),
        itemBuilder: (context, index) {
          DateTime day = now.add(Duration(days: index));
          // Define the color of each day based on discount rules
          Color dayColor;
          double dayDiscount = index == 0 ? 0 : (index * 5).toDouble();
          if (index == 0) {
            dayColor = Colors.redAccent; // No discount today
          } else {
            dayColor = Colors.green.withOpacity(index * 0.2); // Gradual green for future days
          }

          return ScaleTransition(
            scale: CurvedAnimation(
              parent: _calendarAnimationController,
              curve: Interval(0.1 * index, 1.0, curve: Curves.easeOut),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: dayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.E().format(day), // Day name (Mon, Tue, etc.)
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    // Show discount for each day
                    Text(
                      '${dayDiscount.toStringAsFixed(0)}%',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
