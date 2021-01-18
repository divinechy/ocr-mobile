class FormResponse {
  bool status;
  String data;
  String message;

  FormResponse({this.status, this.data, this.message});

  factory FormResponse.fromJson(Map<String, dynamic> parsedJson) {
    return FormResponse(
      status: parsedJson['status'],
      data: parsedJson['data'],
      message: parsedJson['message']
    );
  }
}
