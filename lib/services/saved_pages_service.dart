import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/saved_page.dart';

class SavedPagesService {
  static const String _key = 'saved_pages';

  static Future<List<SavedPage>> getSavedPages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedPagesJson = prefs.getString(_key);
      
      if (savedPagesJson == null) {
        return [];
      }

      final List<dynamic> decoded = json.decode(savedPagesJson);
      return decoded.map((json) => SavedPage.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> savePage(SavedPage savedPage) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<SavedPage> savedPages = await getSavedPages();
      
      // إزالة أي حفظ سابق لنفس الكتاب
      savedPages.removeWhere((page) => page.pdfPath == savedPage.pdfPath);
      
      // إضافة الحفظ الجديد في البداية
      savedPages.insert(0, savedPage);
      
      // حفظ القائمة
      final String encoded = json.encode(
        savedPages.map((page) => page.toJson()).toList(),
      );
      await prefs.setString(_key, encoded);
    } catch (e) {
      // معالجة الخطأ
    }
  }

  static Future<void> deleteSavedPage(String pdfPath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<SavedPage> savedPages = await getSavedPages();
      
      savedPages.removeWhere((page) => page.pdfPath == pdfPath);
      
      final String encoded = json.encode(
        savedPages.map((page) => page.toJson()).toList(),
      );
      await prefs.setString(_key, encoded);
    } catch (e) {
      // معالجة الخطأ
    }
  }

  static Future<SavedPage?> getSavedPageForBook(String pdfPath) async {
    try {
      final savedPages = await getSavedPages();
      return savedPages.firstWhere(
        (page) => page.pdfPath == pdfPath,
        orElse: () => throw Exception('Not found'),
      );
    } catch (e) {
      return null;
    }
  }
}




