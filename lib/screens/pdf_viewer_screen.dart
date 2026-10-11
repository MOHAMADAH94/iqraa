import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/book.dart';
import '../models/saved_page.dart';
import '../services/saved_pages_service.dart';

class PdfViewerScreen extends StatefulWidget {
  final Book book;
  final int? initialPage;

  const PdfViewerScreen({
    super.key,
    required this.book,
    this.initialPage,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PdfViewerController _pdfViewerController;
  int _currentPage = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    
    // تحميل الصفحة المحفوظة إذا كانت موجودة
    if (widget.initialPage != null) {
      _currentPage = widget.initialPage!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pdfViewerController.jumpToPage(widget.initialPage!);
      });
    } else {
      _loadSavedPage();
    }
  }

  Future<void> _loadSavedPage() async {
    final savedPage = await SavedPagesService.getSavedPageForBook(widget.book.pdfPath);
    if (savedPage != null && mounted) {
      setState(() {
        _currentPage = savedPage.pageNumber;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pdfViewerController.jumpToPage(savedPage.pageNumber);
      });
    }
  }

  Future<void> _saveCurrentPage() async {
    await SavedPagesService.savePage(
      SavedPage(
        bookName: widget.book.name,
        pdfPath: widget.book.pdfPath,
        pageNumber: _currentPage,
        savedAt: DateTime.now(),
      ),
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('تم حفظ الصفحة بنجاح'),
            ],
          ),
          backgroundColor: const Color(0xFF3B82F6),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // حفظ تلقائي عند تغيير الصفحة
  Future<void> _autoSavePage() async {
    await SavedPagesService.savePage(
      SavedPage(
        bookName: widget.book.name,
        pdfPath: widget.book.pdfPath,
        pageNumber: _currentPage,
        savedAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: _saveCurrentPage,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            widget.book.pdfPath,
            controller: _pdfViewerController,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _isLoading = false;
              });
              if (widget.initialPage != null) {
                _pdfViewerController.jumpToPage(widget.initialPage!);
              } else {
                _loadSavedPage();
              }
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
              // حفظ تلقائي عند تغيير الصفحة
              _autoSavePage();
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.pageview,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'الصفحة $_currentPage',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

