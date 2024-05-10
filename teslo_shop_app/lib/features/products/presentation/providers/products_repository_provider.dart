import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';

import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';


// OBJECTIVE: of this provider: instantiate the -
// ProductsRepositoryImpl in all the app and use this instance class in
// all the application where it calls methods to ProductsDatasourceImpl


final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  // When some authentication change (user made login or user made log out) 
  // this provider listen the change and redraw this state provider as well
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken),
  );

  return productsRepository; // allow you to call some method of the repository
  // that call to datasource who make the https petitions
  // in the whole application you have access to this provider (access to repository)
});