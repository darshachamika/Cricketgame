import 'dart:math'; // Provides Random for generating the runs.
import 'package:flutter/material.dart'; // Flutter's Material UI widgets.
import 'cricket_art.dart'; // Offline bat and ball drawings.

// Dart starts running the application here.
void main() {
  runApp(const MiniCricketApp());
}

// This widget configures the app; it does not store the changing score.
class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      home: const CricketGame(),
    );
  }
}

// A StatefulWidget is needed because runs and balls change during play.
class CricketGame extends StatefulWidget {
  const CricketGame({super.key});

  @override
  State<CricketGame> createState() => _CricketGameState();
}

class _CricketGameState extends State<CricketGame> {
  final Random _random = Random(); // Reuse one random number generator.
  int totalRuns = 0; // Total score for the current over.
  int balls = 6; // Exactly six deliveries per over.
  String result = ''; // Blank until the first delivery is played.

  // Play one delivery. This method never allows balls to become negative.
  void bat() {
    if (balls <= 0) return;

    final int runs = _random.nextInt(7); // 0, 1, 2, 3, 4, 5 or 6.
    setState(() {
      balls = balls - 1;
      totalRuns = totalRuns + runs;
      result = runs == 0 ? 'No Runs' : '$runs ${runs == 1 ? 'Run' : 'Runs'}';
    });
  }

  // Begin another over by resetting all changing values.
  void restart() {
    setState(() {
      totalRuns = 0;
      balls = 6;
      result = '';
    });
  }

  // Called initially and again after setState updates the game.
  @override
  Widget build(BuildContext context) {
    final bool gameOver = balls == 0;

    return Scaffold(
      backgroundColor: const Color(0xFF007DD5),
      appBar: AppBar(
        title: const Text('Mini Cricket'),
        centerTitle: true,
        backgroundColor: const Color(0xFF083E79),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: max(0.0, constraints.maxHeight - 48),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Two equally sized columns: image, label and value.
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: scoreColumn('Runs', totalRuns, true),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              child: scoreColumn('Balls', balls, false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Text(
                          result,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: gameOver ? restart : bat,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gameOver
                                ? const Color(0xFFD50000)
                                : const Color(0xFF0753AD),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(88, 48),
                          ),
                          child: Text(gameOver ? 'Restart' : 'Bat'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Reuse the same layout for both the Runs and Balls displays.
  Widget scoreColumn(String label, int value, bool isBat) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Semantics(
            label: isBat ? 'Cricket bat' : 'Cricket ball',
            image: true,
            child: CustomPaint(painter: CricketArt(isBat: isBat)),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
