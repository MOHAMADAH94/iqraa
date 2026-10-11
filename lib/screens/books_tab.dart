import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import '../services/saved_pages_service.dart';
import 'pdf_viewer_screen.dart';

class BooksTab extends StatelessWidget {
  const BooksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final books = BookService.getAllBooks();

    return Scaffold(
      body: books.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_books_outlined,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد كتب متاحة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _BookCard(book: book),
                );
              },
            ),
    );
  }
}

class _BookCard extends StatefulWidget {
  final Book book;

  const _BookCard({required this.book});

  @override
  State<_BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<_BookCard>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  String _getBookDescription(String bookName) {
    // إرجاع وصف مناسب لكل كتاب
    final descriptions = {
      'أذكار': 'أذكار الصباح والمساء والنوم',
      'وألحقني بالصالحين': 'كتاب يتناول مواضيع إسلامية مهمة',
      'شخصيات من اعزاز': 'ترجمة الأستاذ أبو الهيثم',
      'مجمع اللؤلؤ والياقوت والمرجان': 'تفسير القرأن',
      'تفسير القرآن': 'تفسير لآيات القرآن الكريم',
      'أدعية نبوية': 'أدعية دعا بها النبي صلى الله عليه وسلم',
      'أدعية قرآنية': 'أدعية وردت في القرآن الكريم',
      'جوامع': 'جوامع الكلم في الدين',
      'خير الأمة': 'كتاب عن خير الأمة وأفضلها',
      'خطوة': 'خطوات في طريق الإيمان',
      'مواريث': 'كتاب في علم المواريث',
      'نجاة': 'كتاب عن النجاة في الدنيا والآخرة',
      'قصص': 'قصص من القرآن والسنة',
      'صلاة': 'كتاب في أحكام الصلاة',
      'سيارات': 'كتاب يتناول مواضيع متنوعة',
      'شمائل': 'شمائل النبي صلى الله عليه وسلم',
      'تفسير': 'تفسير القرآن الكريم',
      'تهذيب': 'تهذيب الأخلاق والسلوك',
      'زاد': 'زاد المسلم في حياته',
      'معتمد المخطوطة': 'كتاب معتمد من المخطوطات',
    };
    return descriptions[bookName] ?? 'كتاب إسلامي مفيد يحتوي على معلومات قيمة';
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerScreen(book: widget.book),
          ),
        );
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.all(6),
            height: 170,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E3A8A),
                  Color(0xFF3B82F6),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(_isPressed ? 0.6 : 0.4),
                  blurRadius: _isPressed ? 16 : 12,
                  spreadRadius: _isPressed ? 2 : 0,
                  offset: Offset(0, _isPressed ? 6 : 4),
                ),
              ],
            ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // العنوان والوصف على اليسار
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // مؤشر الصفحة المحفوظة
                      FutureBuilder(
                        future: SavedPagesService.getSavedPageForBook(widget.book.pdfPath),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'محفوظ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      // العنوان
                      Row(
                        children: [
                          const Icon(
                            Icons.menu_book,
                            color: Colors.white70,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              widget.book.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // الوصف
                      Flexible(
                        child: Text(
                          _getBookDescription(widget.book.name),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // الصورة على اليمين
              Container(
                width: 140,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF3B82F6),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // الصورة
                    Positioned.fill(
                      child: widget.book.imagePath != null
                          ? Image.asset(
                              widget.book.imagePath!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF1E3A8A),
                                        Color(0xFF3B82F6),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.book,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1E3A8A),
                                    Color(0xFF3B82F6),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.book,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

