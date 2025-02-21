import 'package:flutter/material.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'stats_page.dart'; // Import StatsPage

class HomePage extends StatelessWidget {
  final ValueNotifier<double> totalProgressNotifier = ValueNotifier(65.0);
  final ValueNotifier<double> oldTestamentProgressNotifier = ValueNotifier(55.0);
  final ValueNotifier<double> newTestamentProgressNotifier = ValueNotifier(80.0);

  Widget _buildDashedProgress(
      ValueNotifier<double> notifier, double size, String label, Color color) {
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: DashedCircularProgressBar.aspectRatio(
            aspectRatio: 1,
            valueNotifier: notifier,
            progress: notifier.value,
            startAngle: 225,
            sweepAngle: 270,
            foregroundColor: color,
            backgroundColor: const Color(0xffeeeeee),
            foregroundStrokeWidth: 12,
            backgroundStrokeWidth: 12,
            animation: true,
            seekSize: 6,
            seekColor: const Color(0xffeeeeee),
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: notifier,
                builder: (_, double value, __) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${value.toInt()}%',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size * 0.25,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: size * 0.8,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biblia"),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart_rounded), // Stats icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Added 500x500 Image at the top
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset('assets/images/hero.png', fit: BoxFit.contain),
            ),
            SizedBox(height: 20), // Space between image and progress bar
            _buildDashedProgress(totalProgressNotifier, 200, "Bible", Colors.redAccent),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDashedProgress(oldTestamentProgressNotifier, 170, "Old \n Testament", Colors.green),
                SizedBox(width: 50),
                _buildDashedProgress(newTestamentProgressNotifier, 170, "New \n Testament", Colors.blueAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}