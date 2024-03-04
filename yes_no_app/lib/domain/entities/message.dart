enum FromWho {
  me,
  hers
}


class Message {

  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  // Constructor
  Message({
    required this.text,
    this.imageUrl,
    required this.fromWho
  });
  
}

