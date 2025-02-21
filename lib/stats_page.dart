import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  final int oldTestamentChaptersRead = 500, oldTestamentTotalChapters = 929;
  final int newTestamentChaptersRead = 150, newTestamentTotalChapters = 260;
  final int bibleChaptersRead = 650, bibleTotalChapters = 1189;

  final int oldTestamentBooksRead = 30, oldTestamentTotalBooks = 46;
  final int newTestamentBooksRead = 20, newTestamentTotalBooks = 27;
  final int bibleBooksRead = 50, bibleTotalBooks = 73;

  Widget _buildProgressSquare(String title, int read, int total) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$read", // Read Chapters/Books (Top)
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Container(
                width: 40, height: 2, // Middle Line
                color: Colors.blueAccent,
                margin: EdgeInsets.symmetric(vertical: 4),
              ),
              Text(
                "$total", // Total Chapters/Books (Bottom)
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chapter & Book Stats")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Chapters Section
            Text(
              "Chapters",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressSquare("Old Testament", oldTestamentChaptersRead, oldTestamentTotalChapters),
                SizedBox(width: 20),
                _buildProgressSquare("New Testament", newTestamentChaptersRead, newTestamentTotalChapters),
                SizedBox(width: 20),
                _buildProgressSquare("The Bible", bibleChaptersRead, bibleTotalChapters),
              ],
            ),
            SizedBox(height: 30),

            // Books Section
            Text(
              "Books",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressSquare("Old Testament", oldTestamentBooksRead, oldTestamentTotalBooks),
                SizedBox(width: 20),
                _buildProgressSquare("New Testament", newTestamentBooksRead, newTestamentTotalBooks),
                SizedBox(width: 20),
                _buildProgressSquare("The Bible", bibleBooksRead, bibleTotalBooks),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
