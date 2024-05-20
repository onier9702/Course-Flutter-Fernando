import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

// __Note__ Like the name is StateNotifierProvider
// You have the class State(1-), the class Notifier(2-) and the provider(3-)

// 3- provider (this is who you are going to listen via watch or read from outside)
// PROVIDER for LIST
final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {

  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(
    productsRepository: productsRepository,
  );
});

// 1- Class State
class ProductsState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const[],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) => ProductsState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    products: products ?? this.products,
  );

}

// 2- Class Notifier
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({
    required this.productsRepository
  }): super(ProductsState()) {  // create the first instance of the class state
    loadNextPage(); // call the loadNextPage when class state is initializae
  }

  Future<bool> createOrUpdateProductOcurred(Map<String, dynamic> productLike) async {

    try {
      
      final product = await productsRepository.createUpdateProduct(productLike);
      final isProductInList = state.products.any((prod) => prod.id == product.id);

      if (!isProductInList) { // was a creation
        state = state.copyWith(
          products: [product, ...state.products],
        );

      } else { // was an update
        state = state.copyWith(
          products: state.products.map(
            (prod) => prod.id == product.id ? product : prod,
          ).toList()
        );
      }

      return true;

    } catch (e) {
      return false;
    }

  }

  Future loadNextPage() async {

    // avoid to make many unnecessary calls petititions
    // remember it calls many times like events detect in Angular or any state managment strategy
    if (state.isLoading || state.isLastPage) return;

    // This will trigger the first time only
    // and allow the second time it is called return by the line above
    state = state.copyWith(isLoading: true);

    final products = await productsRepository
      .getProductsByPage(limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );

      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      products: [...state.products, ...products],
    );

  }
}