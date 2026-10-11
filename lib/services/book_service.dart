import '../models/book.dart';

class BookService {
  static final List<Book> _books = [
    Book(
      name: 'أذكار',
      pdfPath: 'assets/pdf/azkar.pdf',
      imagePath: 'assets/image/1.png',
    ),
    Book(
      name: 'وألحقني بالصالحين',
      pdfPath: 'assets/pdf/alhekny.pdf',
      imagePath: 'assets/image/2.png',
    ),
    Book(
      name: 'شخصيات من اعزاز',
      pdfPath: 'assets/pdf/azaz.pdf',
      imagePath: 'assets/image/12.png',
    ),
    Book(
      name: 'مجمع اللؤلؤ والياقوت والمرجان',
      pdfPath: 'assets/pdf/tafseer.pdf',
      imagePath: 'assets/image/4.png',
    ),
    Book(
      name: 'أدعية نبوية',
      pdfPath: 'assets/pdf/dnabawi.pdf',
      imagePath: 'assets/image/6.png',
    ),
    Book(
      name: 'أدعية قرآنية',
      pdfPath: 'assets/pdf/dquraany.pdf',
      imagePath: 'assets/image/5.png',
    ),
    Book(
      name: 'إلى الإسلام',
      pdfPath: 'assets/pdf/elaalislam.pdf',
      imagePath: 'assets/image/8.png',
    ),
    Book(
      name: ' فقه الحياة',
      pdfPath: 'assets/pdf/feqeh.pdf',
      imagePath: 'assets/image/15.png',
    ),
    Book(
      name: 'جوامع الإيمان',
      pdfPath: 'assets/pdf/jawamee.pdf',
      imagePath: 'assets/image/10.png',
    ),
    Book(
      name: 'خير أمة',
      pdfPath: 'assets/pdf/kheraomma.pdf',
      imagePath: 'assets/image/17.png',
    ),
    Book(
      name: 'خطوة حاسمة مركبة',
      pdfPath: 'assets/pdf/khotwa.pdf',
      imagePath: 'assets/image/11.png',
    ),
    Book(
      name: 'المواريث',
      pdfPath: 'assets/pdf/mawareth.pdf',
      imagePath: 'assets/image/18.png',
    ),
    Book(
      name: 'النجاء النجاء',
      pdfPath: 'assets/pdf/njaa.pdf',
      imagePath: 'assets/image/14.png',
    ),
    Book(
      name: 'من أصح القصص النبوي',
      pdfPath: 'assets/pdf/qasas.pdf',
      imagePath: 'assets/image/19.png',
    ),
    Book(
      name: 'الصلاة',
      pdfPath: 'assets/pdf/sala.pdf',
      imagePath: 'assets/image/21.png',
    ),
    Book(
      name: 'كتبوا على سياراتهم',
      pdfPath: 'assets/pdf/sayarat.pdf',
      imagePath: 'assets/image/16.png',
    ),
    Book(
      name: 'الشمائل',
      pdfPath: 'assets/pdf/shmaael.pdf',
      imagePath: 'assets/image/20.png',
    ),
    Book(
      name: 'التوهم',
      pdfPath: 'assets/pdf/altawahm.pdf',
      imagePath: 'assets/image/7.png',
    ),
    Book(
      name: 'تهذيب روضة العقلاء ونزهة الفضلاء',
      pdfPath: 'assets/pdf/tahzeeb.pdf',
      imagePath: 'assets/image/9.png',
    ),
    Book(
      name: 'زاد الفتيان',
      pdfPath: 'assets/pdf/zaad.pdf',
      imagePath: 'assets/image/3.png',
    ),
//    Book(
//      name: 'معتمد المخطوطة',
//      pdfPath: 'assets/pdf/معتمدالمخطوطة.pdf',
//      imagePath: 'assets/image/13.png',
//    ),
  ];

  static List<Book> getAllBooks() {
    return _books;
  }

  static Book? getBookByPdfPath(String pdfPath) {
    try {
      return _books.firstWhere((book) => book.pdfPath == pdfPath);
    } catch (e) {
      return null;
    }
  }
}

