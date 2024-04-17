import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {

  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvier);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMoviesPaginated = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMoviesPaginated = ref.watch(popularMoviesProvider);
    final topRatedMoviesPaginated = ref.watch(topRatedMoviesProvider);
    final upcomingMoviesPaginated = ref.watch(upcomingMoviesProvider);

    // SOLUTION WITHOUT SEE THE NAVBAR WHEN WE SCROLL FROM BOTTOM TO TOP
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       const CustomAppbar(),
          
    //       MoviesSlideshow(movies: slideShowMovies),
      
    //       MoviesHorizontalListview(
    //         movies: nowPlayingMoviesPaginated,
    //         title: 'On theater',
    //         subtitle: 'Monday 20',
    //         loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    //       ),
      
    //       MoviesHorizontalListview(
    //         movies: nowPlayingMoviesPaginated,
    //         title: 'Coming soon',
    //         subtitle: 'New',
    //         loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    //       ),
      
    //       MoviesHorizontalListview(
    //         movies: nowPlayingMoviesPaginated,
    //         title: 'Rate',
    //         subtitle: 'starts',
    //         loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    //       ),

    //       MoviesHorizontalListview(
    //         movies: nowPlayingMoviesPaginated,
    //         title: 'Populars',
    //         subtitle: 'most views',
    //         loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    //       ),

    //       const SizedBox(height: 10)
      
    //     ],
    //   ),
    // );

    // SOLUTION viewing THE NAVBAR WHEN WE SCROLL FROM BOTTOM TO TOP
    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // const CustomAppbar(),
                  
                  MoviesSlideshow(movies: slideShowMovies),
              
                  MoviesHorizontalListview(
                    movies: nowPlayingMoviesPaginated,
                    title: 'On theater',
                    subtitle: 'Monday 20',
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MoviesHorizontalListview(
                    movies: popularMoviesPaginated,
                    title: 'Populars',
                    subtitle: 'most views',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),
              
                  MoviesHorizontalListview(
                    movies: upcomingMoviesPaginated,
                    title: 'Upcoming',
                    subtitle: 'soon',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MoviesHorizontalListview(
                    movies: topRatedMoviesPaginated,
                    title: 'Top rated',
                    subtitle: 'most',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),

                  const SizedBox(height: 10)
              
                ],
              );
            },
            childCount: 1,
          )
        ),

      ],
    );
  }
}
