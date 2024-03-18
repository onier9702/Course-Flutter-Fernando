import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {


    Stream<String> getLoadingMessage() {

      final messages = <String>[
        'Loading movies',
        'Buying bread',
        'Loading populars',
        'Calling my girlfriend',
      ];

      return Stream.periodic(const Duration(milliseconds: 1300), (step) {
        return messages[step];
      }).take(messages.length);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Wait please'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),

          StreamBuilder(
            stream: getLoadingMessage(), 
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}