// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_instabuy/services/item_service.dart';
import 'package:flutter_application_instabuy/models/item.dart';

class ProductCard extends StatelessWidget {
  final Item item;
  final String category;

  const ProductCard({
    super.key,
    required this.item,
    required this.category,
  });

  String fetchItemImage(Item item, String size, String prefix) {
    final image = ItemsService();
    return image.fetchItemImage(item, size, prefix).values.first[0];
  }

  @override
  Widget build(BuildContext context) {
    return productCardBuilder();
  }

  Card productCardBuilder() {
    return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductImage(imagePath: fetchItemImage(item, 'medium', 'm')),
        _ProductInfo(item: item, category: category),
      ],
    ),
  );
  }
}

class _ProductImage extends StatelessWidget {
  final String imagePath;

  const _ProductImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        child: Image.network(
          imagePath,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Item item;
  final String category;

  const _ProductInfo({
    required this.item,
    required this.category
    });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          category == 'Ofertas' ?
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'R\$ ${item.prices[0].price?.toStringAsFixed(2).replaceAll('.', ',')}', 
                style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough)),
                TextSpan(text: '    R\$ ${item.prices[0].promoPrice?.toStringAsFixed(2).replaceAll('.', ',')}',
                 style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ) : 
          Text(
            'R\$ ${item.prices[0].price?.toStringAsFixed(2).replaceAll('.', ',')}', 
            style: Theme.of(context).textTheme.titleMedium,
          )

        ],
      ),
    );
  }
}
