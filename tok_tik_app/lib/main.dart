import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tok_tik_app/config/theme/app_theme.dart';
import 'package:tok_tik_app/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:tok_tik_app/infrastructure/repositories/video_posts_repositoy_impl.dart';
import 'package:tok_tik_app/presentation/discover/discover_screen.dart';
import 'package:tok_tik_app/presentation/provider/discover_provider.dart';

void main() => runApp(const MyApp()); // ----- Generated with mateApp snippet ----------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final videoPostRepository = VideoPostsRepositoryImpl(
      videosDataSource: LocalVideoDatasource()
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(videosRepository: videoPostRepository)..loadNestPage()
        )
      ],
      child: MaterialApp(
        title: 'Tok Tik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}
