import 'package:flutter/material.dart';
import 'screens/books_tab.dart';
import 'screens/author_tab.dart';
import 'screens/saved_pages_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إقرأ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF1E3A8A), // أزرق غامق
          secondary: const Color(0xFF3B82F6), // أزرق فاتح
          surface: const Color(0xFF0F172A), // خلفية غامقة جداً
          background: const Color(0xFF0A0E27), // خلفية أساسية
          error: const Color(0xFFEF4444),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E293B),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1E293B),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFF60A5FA),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF3B82F6),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          bodySmall: TextStyle(color: Colors.grey),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    BooksTab(),
    AuthorTab(),
    SavedPagesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إقرأ'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF1E293B),
          selectedItemColor: const Color(0xFF60A5FA),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'الكتب',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'الكاتب',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'الصفحات المحفوظة',
            ),
          ],
        ),
      ),
    );
  }
}
