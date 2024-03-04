import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class HerMessageBubble extends StatelessWidget {

  final Message newMessage;

  const HerMessageBubble({
    super.key,
    required this.newMessage
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(newMessage.text, style: const TextStyle(color: Colors.white),),
          ),
        ),

        const SizedBox(height: 5),
        _ImageBubble(newMessage.imageUrl!),
        const SizedBox(height: 10),
      ],

    );
  }
}

class _ImageBubble extends StatelessWidget {

  final String imageUrl;

  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {

  final Size sizeScreen = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        height: 160,
        width: sizeScreen.width * 0.6,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if ( loadingProgress == null ) return child;
          
          return Container(
            height: 160,
            width: sizeScreen.width * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text('Her is sending an image...'),
          );
        },
      )
    );
  }
}
