
import 'package:tok_tik_app/domain/entities/video_post.dart';
import 'package:tok_tik_app/domain/repositories/video_post_repository.dart';
import 'package:tok_tik_app/infrastructure/datasources/local_video_datasource_impl.dart';

class VideoPostsRepositoryImpl implements VideoPostRepository {

  final LocalVideoDatasource videosDataSource;

  VideoPostsRepositoryImpl({
    required this.videosDataSource
  });

  @override
  Future<List<VideoPost>> getFavoritesVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {
    return videosDataSource.getTrendingVideosByPage(page);
  }



}