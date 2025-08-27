import 'package:flutter/material.dart';
import 'package:marketiapp/features/Home/data/models/Brand/brand_model.dart';

class BrandCard extends StatelessWidget {
  final Brand brand;
  final VoidCallback onTap;

  const BrandCard({
    super.key,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use emoji or fallback to icon
            if (brand.emoji.isNotEmpty)
              Text(
                brand.emoji,
                style: const TextStyle(fontSize: 40),
              )
            else
              const Icon(Icons.business, size: 40, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              brand.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}