import 'package:flutter/material.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({super.key});

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  List<int> balloons = [0, 0, 0, 0, 0];

  // 0 = balloon
  // 1 = pop effect
  // 2 = removed

  int stars = 0;

  void popBalloon(int index) {
    if (balloons[index] != 0) return;

    setState(() {
      balloons[index] = 1;
      stars++;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        balloons[index] = 2;
      });
    });
  }

  void resetGame() {
    setState(() {
      balloons = [0, 0, 0, 0, 0];
      stars = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "🎉 Baby Elephant's Birthday Party",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: resetGame,
            icon: const Icon(Icons.refresh, color: Colors.black54),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF89F7FE), Color(0xFF66A6FF)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
            ),

            Positioned(
              bottom: -100,
              right: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const SizedBox(height: 20),

                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text("🐘", style: TextStyle(fontSize: 120)),

                            const SizedBox(height: 10),

                            const Text(
                              "Tap all balloons to help Baby Elephant decorate the party!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "⭐ Stars: $stars / 5",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: stars / 5,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    const SizedBox(height: 35),

                    Expanded(
                      child: Stack(
                        children: [
                          buildBalloon(index: 0, left: 80, top: 20),

                          buildBalloon(index: 1, right: 10, top: 60),

                          buildBalloon(index: 2, left: 120, top: 80),

                          buildBalloon(index: 3, left: 40, bottom: 60),

                          buildBalloon(index: 4, right: 50, bottom: 90),
                        ],
                      ),
                    ),

                    if (stars == 5)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "🎉 Party Ready!",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Great Job!\nYou helped Baby Elephant decorate the party.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: resetGame,
                      icon: Icon(Icons.refresh),
                      label: Text("Play again"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBalloon({
    required int index,
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onTap: () => popBalloon(index),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: balloons[index] == 0
              ? const Text(
                  "🎈",
                  key: ValueKey("balloon"),
                  style: TextStyle(fontSize: 80),
                )
              : balloons[index] == 1
              ? const Text(
                  "💥",
                  key: ValueKey("boom"),
                  style: TextStyle(fontSize: 90),
                )
              : const SizedBox(key: ValueKey("empty")),
        ),
      ),
    );
  }
}
