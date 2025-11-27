import 'package:flutter/material.dart';
import 'data_storage_service.dart';

class ChaptersPage extends StatefulWidget {
  final Map<String, dynamic> book;

  const ChaptersPage({Key? key, required this.book}) : super(key: key);

  @override
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  late List<bool> isSelected;
  final DataStorageService _storageService = DataStorageService();

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.filled(widget.book["chapters"], false);
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final progressData = await _storageService.loadData(widget.book["name"]);
      if (progressData.isNotEmpty) {
        setState(() {
          isSelected = List<bool>.from(progressData['isSelected']);
        });
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  Future<void> _saveProgress() async {
    try {
      await _storageService.saveData(widget.book["name"], {
        'isSelected': isSelected,
      });
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  void toggleMarkAll() {
    setState(() {
      bool allRead = isSelected.every((element) => element);
      isSelected = List<bool>.filled(widget.book["chapters"], !allRead);
    });
    _saveProgress();
  }

  @override
  Widget build(BuildContext context) {
    int completedChapters = isSelected.where((e) => e).length;
    int totalChapters = widget.book["chapters"];
    double completion = (completedChapters / totalChapters) * 100;

    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222831),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, completedChapters); // Pass back the number of completed chapters
          },
        ),
        actions: [
          TextButton.icon(
            onPressed: toggleMarkAll,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: const Text("Mark all as read", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${widget.book["name"]}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${completion.toStringAsFixed(1)}% Completed",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: widget.book["chapters"],
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                      _saveProgress();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: isSelected[index] ? const Color(0xFF5EDC78) : const Color(0xFFD6D6D6),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected[index] ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Completed: $completedChapters",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Total: $totalChapters",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}