import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.image, height: 250)),
            const SizedBox(height: 16),
            Text(product.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 12),
            Text('Categoria: ${product.category}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text(product.description),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 6),
                Text('${product.rating} (${product.ratingCount} reviews)')
              ],
            )
          ],
        ),
      ),
    );
  }
}
