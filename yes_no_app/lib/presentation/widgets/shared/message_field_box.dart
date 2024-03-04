import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {

  final ValueChanged<String> onValue;

  // Constructor
  const MessageFieldBox({
    super.key,
    required this.onValue
  });

  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;

    final textController = TextEditingController();
    final FocusNode focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final InputDecoration inputDecoration = InputDecoration(
      hintText: 'End the message with ?',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = textController.value.text;
          // print('Text value $textValue');
          onValue(textValue);
          textController.clear();
        }, 
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        // print('Submit value: $value');
        onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
      // onChanged: (value) {
      //   // print('Changed value: $value');
      // },
    );
  }
}
