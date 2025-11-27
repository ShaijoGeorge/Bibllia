import 'package:flutter/material.dart';

class BookGrid extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> categorizedBooks;
  final void Function(BuildContext context, Map<String, dynamic> book, String category, int index) onBookTap;

  const BookGrid({
    Key? key,
    required this.categorizedBooks,
    required this.onBookTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: categorizedBooks.keys.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categorizedBooks[category]!.length,
              itemBuilder: (context, index) {
                final book = categorizedBooks[category]![index];
                int readChapters = book["read"] ?? 0; // Get the number of chapters read
                double progress = book["chapters"] > 0 ? readChapters / book["chapters"] : 0.0; // Calculate progress

                return GestureDetector(
                  onTap: () {
                    onBookTap(context, book, category, index); // Use the callback
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFD6D6D6),
                        ),
                      ),
                      Positioned.fill(
                        child: FractionallySizedBox(
                          widthFactor: progress,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF5EDC78),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          book["name"],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
          ],
        );
      }).toList(),
    );
  }
}