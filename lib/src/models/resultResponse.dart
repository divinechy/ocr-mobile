class ResultResponse{
  bool status;
  dynamic message;

  ResultResponse({this.status, this.message});

  factory ResultResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ResultResponse(
      status: parsedJson['status'],
      message: parsedJson['message']
    );
  }
}
