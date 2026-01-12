import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote_model.dart';
import '../services/quote_service.dart';

class QuoteProvider extends ChangeNotifier {
  final QuoteService _service = QuoteService();

  QuoteModel? currentQuote;
  List<QuoteModel> favorites = [];
  bool isLoading = false;

  /// Always use Picsum (direct HTTPS, no redirects)
  String currentImageUrl =
      'https://picsum.photos/seed/init/800/600';

  QuoteProvider() {
    loadFavorites();
  }

  Future<void> fetchQuote() async {
    isLoading = true;
    notifyListeners();

    try {
      currentQuote = await _service.fetchRandomQuote();
    } catch (e) {
      currentQuote = QuoteModel(
        id: 'offline',
        content:
        'The best way to get started is to quit talking and begin doing.',
        author: 'Walt Disney',
        category: 'Inspiration',
      );
    }

    /// 🔥 FORCE A NEW IMAGE EVERY TIME (NO CACHE)
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    currentImageUrl = 'https://picsum.photos/seed/$timestamp/800/600';

    isLoading = false;
    notifyListeners();
  }

  // -------------------- FAVORITES --------------------

  bool isFavorite(String id) {
    return favorites.any((q) => q.id == id);
  }

  void toggleFavorite(QuoteModel quote) {
    if (isFavorite(quote.id)) {
      favorites.removeWhere((q) => q.id == quote.id);
    } else {
      favorites.add(quote);
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = favorites.map((q) => json.encode(q.toJson())).toList();
    await prefs.setStringList('favorites', data);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('favorites') ?? [];

    favorites =
        data.map((q) => QuoteModel.fromJson(json.decode(q))).toList();

    notifyListeners();
  }
}
