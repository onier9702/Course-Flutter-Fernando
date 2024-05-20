import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

import 'package:teslo_shop/features/shared/shared.dart';

// autodispose => onDestroy will clean the state
// family => means that it will receive argument

// 3-> provider
// PROVIDER where form create or update the product
final productFormProvider = StateNotifierProvider.autoDispose.family<ProductFormNotifier, ProductFormState, Product>((ref, product) {

  // final createUpdateCallback = ref.watch(productsRepositoryProvider).createUpdateProduct;

  // OJO: now the call to datasource is from products provider
  final createUpdateCallback = ref.watch(productsProvider.notifier).createOrUpdateProductOcurred;

  return ProductFormNotifier(
    product: product,
    onSubmitCallback: createUpdateCallback
  );
});

// 1-> State
class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const[],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const[],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) => ProductFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    sizes: sizes ?? this.sizes,
    gender: gender ?? this.gender,
    inStock: inStock ?? this.inStock,
    description: description ?? this.description,
    tags: tags ?? this.tags,
    images: images ?? this.images,
  );
}

// 2-> Notifier

class ProductFormNotifier extends StateNotifier<ProductFormState> {

  final Future<bool> Function(Map<String, dynamic> productLike)? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }): super(
    ProductFormState(
      id: product.id,
      title: Title.dirty(product.title),
      slug: Slug.dirty(product.slug),
      price: Price.dirty(product.price),
      inStock: Stock.dirty(product.stock),
      sizes: product.sizes,
      gender: product.gender,
      description: product.description,
      tags: product.tags.join(', '),
      images: product.images,
    )
  );

  Future<bool> onFormSubmit() async {

    _touchedEveryField();

    if (!state.isFormValid) return false;

    // PASS the onSubmitCallback
    if (onSubmitCallback == null) return false;

    final productLike = {
      'id': (state.id == 'new') ? null : state.id,
      'title': state.title.value, // from object from formz
      'price': state.price.value, // from object from formz
      'slug': state.slug.value, // from object from formz
      'stock': state.inStock.value, // from object from formz
      'description': state.description,
      'sizes': state.sizes,
      'gender': state.gender,
      'tags': state.tags.split(','),
      'images': state.images.map(
        (img) => img.replaceAll('${Environment.baseUrl}/files/product/', '')
      ).toList(),
    };

    try {

      return await onSubmitCallback!(productLike);
      
    } catch (e) {
      return false;
    }

  }

  void _touchedEveryField() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]) && state.description.isNotEmpty,
    );
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]) && state.description.isNotEmpty,
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Slug.dirty(value),
        Title.dirty(state.title.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]) && state.description.isNotEmpty,
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Price.dirty(value),
        Slug.dirty(state.slug.value),
        Title.dirty(state.title.value),
        Stock.dirty(state.inStock.value),
      ]) && state.description.isNotEmpty,
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Stock.dirty(value),
        Price.dirty(state.price.value),
        Slug.dirty(state.slug.value),
        Title.dirty(state.title.value),
      ]) && state.description.isNotEmpty,
    );
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(
      sizes: sizes,
    );
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(
      gender: gender,
    );
  }

  void onDescriptionChanged( String description) {
    state = state.copyWith(
      description: description,
      isFormValid: Formz.validate([
        Stock.dirty(state.inStock.value),
        Price.dirty(state.price.value),
        Slug.dirty(state.slug.value),
        Title.dirty(state.title.value),
      ]) && description.isNotEmpty,
    );
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(
      tags: tags,
    );
  }
  
}
