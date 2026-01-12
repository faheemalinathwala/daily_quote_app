import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quote_app/widgets/circle_icon_button.dart';

class FavoriteQuoteCard extends StatelessWidget {
  final dynamic quote;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const FavoriteQuoteCard({
    required this.quote,
    required this.onLike,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// CATEGORY + HEART
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                quote.category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.blue),
                onPressed: onLike,
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// QUOTE
          Text(
            '"${quote.content}"',
            style: const TextStyle(
              fontSize: 18,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          /// AUTHOR
          Text(
            '— ${quote.author}',
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),

          const SizedBox(height: 16),

          /// ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleIconButton(
                icon: Icons.copy,
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: quote.content),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Quote copied')),
                  );
                },
              ),
              const SizedBox(width: 12),
              CircleIconButton(
                icon: Icons.share,
                onTap: onShare,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
