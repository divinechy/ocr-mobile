class MessageResponse {
  String name;
  String formUrl;
  String document;
  String date;
  String remarks;

  MessageResponse(
      {this.name, this.formUrl, this.document, this.date, this.remarks});

  factory MessageResponse.fromJson(Map<String, dynamic> parsedJson) {
    return MessageResponse(
        name: parsedJson['name'],
        formUrl: parsedJson['formUrl'],
        document: parsedJson['document'],
        date: parsedJson['date'],
        remarks: parsedJson['remarks']);
  }
}

class ListMessageResponse {
  List<MessageResponse> myMessages;

  ListMessageResponse({this.myMessages});

  factory ListMessageResponse.fromJson(List<dynamic> parsedJson) {
    List<MessageResponse> messages = new List<MessageResponse>();
    //mapping each item in message as a list
    messages = parsedJson.map((i) => MessageResponse.fromJson(i)).toList();
    return ListMessageResponse(myMessages: messages);
  }
}
