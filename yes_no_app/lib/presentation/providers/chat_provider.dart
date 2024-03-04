import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {

  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [
    Message(text: 'Hi darling!', fromWho: FromWho.me),
    Message(text: 'Did you already get back from home ?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {

    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);

    if (text.endsWith('?')) {
      await herReply();
    }

    // Tell listeners that new change occured
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();

    messages.add(herMessage);
  }

  Future<void> moveScrollToBottom() async {

    // Importan this delay to let flutter process the message and then make the animateTo controller scroll
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }

}