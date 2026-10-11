import 'package:flutter/material.dart';
import '../models/saved_page.dart';
import '../services/saved_pages_service.dart';
import '../services/book_service.dart';
import 'pdf_viewer_screen.dart';

class SavedPagesTab extends StatefulWidget {
  const SavedPagesTab({super.key});

  @override
  State<SavedPagesTab> createState() => _SavedPagesTabState();
}

class _SavedPagesTabState extends State<SavedPagesTab> {
  List<SavedPage> _savedPages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedPages();
  }

  Future<void> _loadSavedPages() async {
    setState(() {
      _isLoading = true;
    });
    final savedPages = await SavedPagesService.getSavedPages();
    setState(() {
      _savedPages = savedPages;
      _isLoading = false;
    });
  }

  Future<void> _deleteSavedPage(SavedPage savedPage) async {
    await SavedPagesService.deleteSavedPage(savedPage.pdfPath);
    _loadSavedPages();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حذف الصفحة المحفوظة'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _openBook(SavedPage savedPage) {
    final book = BookService.getBookByPdfPath(savedPage.pdfPath);
    if (book != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(
            book: book,
            initialPage: savedPage.pageNumber,
          ),
        ),
      ).then((_) {
        // إعادة تحميل القائمة بعد العودة
        _loadSavedPages();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _savedPages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد صفحات محفوظة',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadSavedPages,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _savedPages.length,
                    itemBuilder: (context, index) {
                      final savedPage = _savedPages[index];
                      return _SavedPageCard(
                        savedPage: savedPage,
                        onTap: () => _openBook(savedPage),
                        onDelete: () => _deleteSavedPage(savedPage),
                      );
                    },
                  ),
                ),
    );
  }
}

class _SavedPageCard extends StatelessWidget {
  final SavedPage savedPage;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _SavedPageCard({
    required this.savedPage,
    required this.onTap,
    required this.onDelete,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E293B),
                const Color(0xFF1E293B).withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF3B82F6).withOpacity(0.2),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF3B82F6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      savedPage.bookName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.pageview,
                          size: 16,
                          color: Color(0xFF60A5FA),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'الصفحة: ${savedPage.pageNumber}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF60A5FA),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'حُفظ في: ${_formatDate(savedPage.savedAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

