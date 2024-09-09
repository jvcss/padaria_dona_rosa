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
      insetPadding: const EdgeInsets.all(3),
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
          child: const Text('Vou voltar Amanhã'),
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
        clipBehavior: Clip.none,
        shrinkWrap: true,
        itemCount: 7,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 0.5,
          crossAxisCount: 7, // 7 days in a week
        ),
        itemBuilder: (context, index) {
          DateTime day = now.add(Duration(days: index));
          // Define the color of each day based on discount rules
          Color dayColor;
          double dayDiscount = index == 0 ? 0 : (index < 6 ? index : 5).toDouble();

          // Using ternary to ensure opacity stays within 0.0 and 1.0
          dayColor = index == 0
              ? Colors.redAccent // No discount today
              : Colors.green.withOpacity(index * 0.166 <= 1.0 ? index * 0.166 : 1.0);

          return ScaleTransition(
            scale: CurvedAnimation(
              parent: _calendarAnimationController,
              curve: Interval(0.1 * index, 1, curve: Curves.easeOut),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              constraints: const BoxConstraints(
                minHeight: 12, // Ensure minimum height for readability
                minWidth: 12, // Ensure minimum width for readability
              ),
              decoration: BoxDecoration(
                color: dayColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.E().format(day), // Day name (Mon, Tue, etc.)
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    // Show discount for each day
                    Text(
                      '${dayDiscount.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
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
