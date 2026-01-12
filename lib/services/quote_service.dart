import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class QuoteService {
  static const _url = 'https://zenquotes.io/api/random';

  Future<QuoteModel> fetchRandomQuote() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      final quote = data.first;

      return QuoteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: quote['q'],
        author: quote['a'],
        category: 'Inspiration',
      );
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
