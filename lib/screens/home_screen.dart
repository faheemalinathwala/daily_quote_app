import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

import '../providers/quote_provider.dart';
import '../widgets/action_button.dart';
import '../widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuoteProvider>().fetchQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuoteProvider>();
    final quote = provider.currentQuote;
    final date = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : quote == null
            ? const Center(child: Text('Failed to load quote'))
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    /// HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.blueGrey,
                        ),
                        Column(
                          children: [
                            const Text(
                              'DAILY INSPIRATION',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 2,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.settings_outlined,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// QUOTE CARD
                    Expanded(
                      child: QuoteCard(
                        quote: quote,
                        imageUrl: provider.currentImageUrl,
                        bottomSection: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ActionButton(
                              icon: provider.isFavorite(quote.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              label: 'LIKE',
                              onTap: () => provider.toggleFavorite(quote),
                            ),
                            GestureDetector(
                              onTap: provider.fetchQuote,
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.blue,
                                child: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                            ActionButton(
                              icon: Icons.share,
                              label: 'SHARE',
                              onTap: () {
                                Share.share(
                                  '"${quote.content}" — ${quote.author}',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
