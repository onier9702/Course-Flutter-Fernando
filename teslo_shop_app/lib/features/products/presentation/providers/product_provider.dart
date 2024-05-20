import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'products_repository_provider.dart';
import '../../domain/domain.dart';


// PROVIDER for EDIT SCREEN if id !== 'new', if not it is NEW CREATE
final singleProductProvider = StateNotifierProvider
  .autoDispose.family<ProductNotifier, ProductState, String>((ref, productId) {

    final productsRepository = ref.watch(productsRepositoryProvider);

    return ProductNotifier(
      productsRepository: productsRepository,
      productId: productId,
    );
});


// STATE
class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) => ProductState(
    id: id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
  
}

// NOTIFIER
class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;

  // constructor
  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }): super(ProductState(id: productId)) {  // initialize the class state (all props)
    loadProduct();
  }

  Product _newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'men',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {

    try {

      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: _newEmptyProduct(),
        );

        return;
      }
      
      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    
    } catch (e) {
      // 404 product not found
      print(e);
    }

  }

}