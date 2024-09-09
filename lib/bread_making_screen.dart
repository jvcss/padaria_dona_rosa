import 'package:flutter/material.dart';
import 'package:padaria_dona_rosa/bread.dart';
import 'package:padaria_dona_rosa/checkout_screen.dart';
import 'package:padaria_dona_rosa/dougth.dart';

class BreadMakingScreen extends StatefulWidget {
  const BreadMakingScreen({super.key});

  @override
  BreadMakingScreenState createState() => BreadMakingScreenState();
}

class BreadMakingScreenState extends State<BreadMakingScreen> with SingleTickerProviderStateMixin {
  bool isDough = true; // Controls whether it's dough or bread phase
  bool isLoading = false; // Controls whether the loading animation is shown
  int breadCount = 0; // Counts how many breads have been added

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateToBread() {
    setState(() {
      isLoading = true; // Show the loading animation
    });

    _controller.forward(); // Start rolling pin animation

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isDough = false; // Switch to bread after the loading animation
        breadCount += 1; // Increase the bread count
        isLoading = false; // Hide the loading animation
        _controller.stop(); // Stop rolling pin animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padaria Artesanal'),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: isDough ? const DoughCard(key: ValueKey(1)) : BreadCard(key: const ValueKey(2), breadCount: breadCount),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: breadCount > 0
                          ? () {
                              setState(() {
                                breadCount--;
                                if (breadCount == 0) {
                                  isDough = true; // Switch back to dough if bread count is zero
                                }
                              });
                            }
                          : null,
                    ),
                    Text('$breadCount ${breadCount == 1 ? 'pão' : 'pães'}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: (){
                        if (isDough) {
                          _animateToBread();
                        } else {
                          setState(() {
                            breadCount++;
                          });
                        }
                      }, // Trigger the transition to bread
                    ),
                  ],
                ),
              ],
            ),
            if (isLoading)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/rolling_pin.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(totalAmount: breadCount * 5.0),
            ),
          );
        },
        child: const Icon(Icons.shopping_basket),
      ),
    );
  }
}
