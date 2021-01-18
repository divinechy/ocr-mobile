class LoginResponse {
  final String token;
  final String message;
  final String appicationSubscriberName;
  final String applicationUserEmail;
  final String applicationUserFirstName;
  final String applicationUserLast;
  final String applicationUserPhoneNumber;

  LoginResponse({
    this.token,
    this.message,
    this.appicationSubscriberName,
    this.applicationUserEmail,
    this.applicationUserFirstName,
    this.applicationUserLast,
    this.applicationUserPhoneNumber,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return LoginResponse(
      token: parsedJson['token'],
      message: parsedJson['message'],
      appicationSubscriberName: parsedJson['appicationSubscriberName'],
      applicationUserEmail: parsedJson['applicationUserEmail'],
      applicationUserFirstName: parsedJson['applicationUserFirstName'],
      applicationUserLast: parsedJson['applicationUserLast'],
      applicationUserPhoneNumber: parsedJson['applicationUserPhoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "message": message,
        "appicationSubscriberName": appicationSubscriberName,
        "applicationUserEmail": applicationUserEmail,
        "applicationUserFirstName": applicationUserFirstName,
        "applicationUserLast": applicationUserLast,
        "applicationUserPhoneNumber": applicationUserPhoneNumber
      };
}
