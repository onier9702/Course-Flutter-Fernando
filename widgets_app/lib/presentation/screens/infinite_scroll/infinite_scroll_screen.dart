import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {

  static const name = 'infinite_scroll_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {

  List<int> imagesId = [1, 2, 3, 4, 5, 6];
  final ScrollController listviewScrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    listviewScrollController.addListener(() { // LISTENER
      // if position we are in is equal to final scroll
      // 500 is to be flexible with user experience and not launch pull refresh when end
      if ( (listviewScrollController.position.pixels + 500) >=
      listviewScrollController.position.maxScrollExtent ) {
        // Load next page
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    listviewScrollController.dispose();
    isMounted = false; // IMPORTANT TO AVOID CALL SET STATE WHEN THIS WAS KILLED
    super.dispose();
  }

  Future loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {}); // this draw again UI and spin perfect is displayed

    await Future.delayed(const Duration(seconds: 2));

    addFiveImages();
    isLoading = false;

    if (!isMounted) return; // to avoid error when user leave the page abruptly

    setState(() {}); // this draw the UI again displaying the new 5 images

    // Move scroll a little when is at end
    moveScrollToBottom();
  }

  // Move scroll a little when is at end
  void moveScrollToBottom() {
    if((listviewScrollController.position.pixels + 100)
     <= listviewScrollController.position.maxScrollExtent) return;

    listviewScrollController.animateTo(
      listviewScrollController.position.pixels + 120, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.fastOutSlowIn
    );
  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));
    if ( !isMounted ) return;

    isLoading = false;
    final lastId = imagesId.last;
    imagesId.clear();
    imagesId.add(lastId + 1 );
    addFiveImages();

    setState(() {});
  }


  void addFiveImages() {
    final lastId = imagesId.last;
    imagesId.addAll(
      [1,2,3,4,5].map((e) => lastId + e)
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Infinite scroll'),
      // ),
      body: MediaQuery.removePadding( // to remove blank space on top
        context: context, // to remove blank space on top
        removeTop: true, // to remove blank space on top
        removeBottom: true, // to remove blank space on top
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: ListView.builder(
            controller: listviewScrollController,
            itemCount: imagesId.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage('https://picsum.photos/id/${imagesId[index]}/500/300')
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: isLoading 
          ? SpinPerfect(
              infinite: true,
              child: const Icon(Icons.refresh_rounded)
            )
          : const Icon(Icons.arrow_back),
      ),

    );
  }
}
