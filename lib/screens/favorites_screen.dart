import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_app/widgets/favorite_quote_card.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/quote_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuoteProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Saved Favorites',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: provider.favorites.isEmpty
          ? const Center(
        child: Text(
          'No favorites yet',
          style: TextStyle(color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.favorites.length,
        itemBuilder: (context, index) {
          final quote = provider.favorites[index];

          return FavoriteQuoteCard(
            quote: quote,
            onLike: () => provider.toggleFavorite(quote),
            onShare: () {
              Share.share(
                '"${quote.content}" — ${quote.author}',
              );
            },
          );
        },
      ),
    );
  }
}
