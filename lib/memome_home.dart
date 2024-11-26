//memome_home.dart
import 'package:flutter/material.dart';
import 'add_memo_page.dart';
import 'memo_list_screen.dart';
import 'quiz_page.dart';

class MemomeHome extends StatefulWidget {
  const MemomeHome({super.key});

  @override
  _MemomeHomeState createState() => _MemomeHomeState();
}

class _MemomeHomeState extends State<MemomeHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to Memo List Page (book icon)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MemoListScreen()),
      );
    } else if (index == 2) {
      // Placeholder for Statistics Page (bar_chart icon)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Statistics Page coming soon!')),
      );
    } else if (index == 3) {
      // Navigate to Quiz Page (light bulb icon)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StartQuizPage()), // Use StartQuizPage here
      );

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: const Color(0xFF6A9FB5),
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: const Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    LogoWidget(),
    SizedBox(width: 10),
    Expanded(
    child: Text(
    'MemoMe',
    style: TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFFC128),
    fontFamily: 'Open Sans',
    ),
    overflow: TextOverflow.ellipsis,
    ),
    ),
    ],
    ),
    ),
    body: Container(
    color: const Color(0xFFF5F5F5),
    padding: const EdgeInsets.all(16.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const Text(
    'Add a new memo',
    style: TextStyle(
    fontSize: 40,
    color: Color(0xFF333333),
    fontFamily: 'Open Sans',
    ),
    ),
    const SizedBox(height: 10),
    // Button to add a new memo
    Center(
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFC128),
    foregroundColor: const Color(0xFF333333),
    padding: const EdgeInsets.all(20),
    fixedSize: const Size(90, 90),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    ),
    ),
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddMemoPage()),
    );
    },
    child: const Icon(Icons.add, size: 50),
    ),
    ),
    const SizedBox(height: 30),
    const Text(
    'Start a quiz',
    style: TextStyle(
    fontSize: 40,
    color: Color(0xFF333333),
    fontFamily: 'Open Sans',
    ),
    ),
    const SizedBox(height: 10),
    // Button to start a quiz
    Center(
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFC128),
    foregroundColor: const Color(0xFF333333),
    padding: const EdgeInsets.all(20),
    fixedSize: const Size(90, 90),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    ),
    ),
    onPressed: () {
    Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const StartQuizPage()),
    );
    },
    child: const Icon(Icons.lightbulb, size: 50),
    ),
    ),
    ],
    ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF6A9FB5),
        selectedItemColor: const Color(0xFFF5F5F5),
        unselectedItemColor: const Color(0xFF333333),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 80),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 80), // Book icon for Memo List
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, size: 80), // Bar chart icon for Statistics
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 80), // Settings icon
            label: '',
          ),
        ],
      ),

 ); } }

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 5,
            top: 5,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF81BED8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFFC128),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
