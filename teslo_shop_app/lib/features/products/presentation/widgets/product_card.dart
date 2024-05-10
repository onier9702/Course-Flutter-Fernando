import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // IMG
        _ImageView(images: product.images),

        // INFO
        Text(product.title, textAlign: TextAlign.center,),
        const SizedBox(height: 20),

      ],
    );
  }
}

class _ImageView extends StatelessWidget {

  final List<String> images;

  const _ImageView({
    required this.images
  });

  @override
  Widget build(BuildContext context) {

    if (images.isEmpty) {

      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          fit: BoxFit.cover,
          height: 250,
          // These two commented lines does not work
          // fadeInDuration: const Duration(microseconds: 200),
          // fadeOutDuration: const Duration(microseconds: 100),
          image: NetworkImage(
            images.first
          ),
          placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
        ),
    );
    
  }
}
