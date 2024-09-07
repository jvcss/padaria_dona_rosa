import 'package:flutter/material.dart';
import 'package:padaria_dona_rosa/bread.dart';
import 'package:padaria_dona_rosa/dougth.dart';

class BreadMakingScreen extends StatefulWidget {
  const BreadMakingScreen({super.key});

  @override
  BreadMakingScreenState createState() => BreadMakingScreenState();
}

class BreadMakingScreenState extends State<BreadMakingScreen> {
  bool isDough = true; // Controla se está na fase da massa ou do pão
  int breadCount = 0; // Conta quantos pães foram adicionados

  void _animateToBread() {
    setState(() {
      isDough = false; // Muda o estado para mostrar o pão ao invés da massa
      breadCount += 1; // Aumenta a contagem de pães
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padaria Artesanal'),
      ),
      body: Center(
        child: Column(
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
                              isDough = true; // Volta para a massa quando zera
                            }
                          });
                        }
                      : null,
                ),
                Text('$breadCount pães'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _animateToBread, // Transiciona para o pão
                ),
              ],
            ),
          ],
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ? navegar para tela de finalzar compra
        },
        child: const Icon(Icons.shopping_basket),
      ),
    );
  }
}
