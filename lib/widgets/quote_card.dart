import 'package:flutter/material.dart';
import '../models/quote_model.dart';

class QuoteCard extends StatelessWidget {
  final QuoteModel quote;
  final String imageUrl;
  final Widget bottomSection;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.imageUrl,
    required this.bottomSection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          /// 🔥 SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.format_quote,
                    size: 48,
                    color: Color(0xFFDCE4FF),
                  ),
                  const SizedBox(height: 12),

                  /// QUOTE TEXT (NO OVERFLOW)
                  Text(
                    '"${quote.content}"',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: 40,
                    height: 2,
                    color: Colors.blue.shade200,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '— ${quote.author}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// IMAGE (RESPONSIVE HEIGHT)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        imageUrl,
                        key: ValueKey(imageUrl),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image, size: 40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔥 FIXED BOTTOM ACTIONS (NO OVERFLOW)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: bottomSection,
          ),
        ],
      ),
    );
  }
}
