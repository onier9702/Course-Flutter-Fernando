import 'package:dio/dio.dart';

import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

import '../errors/product_errors.dart';
import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {

  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({
    required this.accessToken
  }): dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      }
    ),
  );

  Future<String> _uploadSinglePhoto(String path) async {
    try {
      
      final fileName = path.split('/').last;
      final FormData formData = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName),
      });

      final response = await dio.post('/files/product', data: formData);

      return response.data['image'];
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<String>> _uploadPhotos(List<String> photos) async {
    final photosToUpload = photos.where( (img) {
      return (img.contains('/') && !img.contains('http')) 
        ? true
        : false;
    }).toList();

    final photosToKeep = photos.where((img) {
      return (!img.contains('/') || img.contains('http')) 
        ? true
        : false;
    }).toList();

    // Call all the request to upload image in a single future
    // the same JavaScript to use Promise.all(<arrPromises>)
    final List<Future<String>> uploadArrFutures = photosToUpload.map(
      (e) => _uploadSinglePhoto(e)
    ).toList();

    final newImages = await Future.wait(uploadArrFutures);

    return [...photosToKeep, ...newImages];

  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    
    try {

      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url = productId == null
        ? '/products'
        : '/products/$productId';

      productLike.remove('id');
      // Update images to upload
      productLike['images'] = await _uploadPhotos(productLike['images']);

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method
        )
      );

      final product = ProductMapper.jsonToEntity(response.data);

      return product;
      
    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<Product> getProductById(String id) async {

    try {
      
      final response = await dio.get('/products/$id');

      final product = ProductMapper.jsonToEntity(response.data);

      return product;

    } on DioException catch(e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();

    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];

    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product)); // mapper
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    throw UnimplementedError();
  }



}