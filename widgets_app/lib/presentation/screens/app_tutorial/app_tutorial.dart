import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo('Bring the food', 'Proident non eiusmod nostrud et ut anim occaecat id minim sint est culpa velit ullamco.', 'assets/images/1.png'),
  SlideInfo('Fast deliver', 'Pariatur ut sit anim consequat nisi.', 'assets/images/2.png'),
  SlideInfo('Enjoy the food', 'Tempor eiusmod cillum culpa nostrud occaecat in culpa voluptate sint non.', 'assets/images/3.png'),
];

class AppTutotialScreen extends StatefulWidget {

  static const name = 'app_tutorial_screen';

  const AppTutotialScreen({super.key});

  @override
  State<AppTutotialScreen> createState() => _AppTutotialScreenState();
}

class _AppTutotialScreenState extends State<AppTutotialScreen> {

  final PageController pageViewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {

      final page = pageViewController.page ?? 0;
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }

    });
  }

  @override
  void dispose() { // KILL THE LISTENER - IMPORTANT
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(), // the same behavior in IOS and androide
            children: slides.map(
              (slidedata) => _Slide(
                title: slidedata.title,
                caption: slidedata.caption,
                imageUrl: slidedata.imageUrl,
              )
            ).toList(),
          ),

          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Skip'))
          ),

          endReached 
          ? Positioned(
            bottom: 80,
            right: 30,
            child: FadeInRight(
              from: 15,
              duration: const Duration(seconds: 1),
              child: FilledButton(
                child: const Text('Start'),
                onPressed: () {
                  context.pop();
                },
              ),
            )
          )
          : const SizedBox(), // It is recommended to display a SizedBox to not show any widgets

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title,
    required this.caption,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(height: 20),
            Text(title, style: titleStyle),
            const SizedBox(height: 10),
            Text(caption, style: captionStyle),
          ],
        ),
      ),
    );
  }
}
