import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {

    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Hello world'),
      action: SnackBarAction(label: 'OK!', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // to avoid click outside that close modal
      builder: (context) => AlertDialog(
        title: const Text('Are you sure ?'),
        content: const Text('Ullamco reprehenderit cillum ut Lorem enim eu nisi culpa quis amet.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel')
          ),
          FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Accept')
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars and dialogs'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Voluptate aliquip irure sunt magna duis fugiat ex laboris commodo nostrud non qui esse. Voluptate sint enim dolore exercitation irure ad reprehenderit.')
                  ]
                );
              },
              child: const Text('Licenses used')
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text('Display dialogs')
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Show snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
