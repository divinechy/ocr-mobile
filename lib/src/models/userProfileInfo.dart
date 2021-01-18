
class UserProfileInfo {
  final String token;
  final String message;
  final String appicationSubscriberName;
  final String applicationUserEmail;
  final String applicationUserFirstName;
  final String applicationUserLast;
  final String applicationUserPhoneNumber;
  List<int> itemCount = [0];

  UserProfileInfo({
    this.token,
    this.message,
    this.appicationSubscriberName,
    this.applicationUserEmail,
    this.applicationUserFirstName,
    this.applicationUserLast,
    this.applicationUserPhoneNumber,
    this.itemCount,
  });

  factory UserProfileInfo.fromJson(Map<String, dynamic> jsonData) {
    return UserProfileInfo(
      applicationUserFirstName: jsonData['applicationUserFirstName'],
      applicationUserLast: jsonData['applicationUserLast'],
      applicationUserPhoneNumber: jsonData['applicationUserPhoneNumber'],
      appicationSubscriberName: jsonData['appicationSubscriberName'],
      applicationUserEmail: jsonData['applicationUserEmail'],
      token: jsonData['token'],
            
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "appicationSubscriberName": appicationSubscriberName,
        "applicationUserEmail": applicationUserEmail,
        "applicationUserFirstName": applicationUserFirstName,
        "applicationUserLast": applicationUserLast,
        "applicationUserPhoneNumber": applicationUserPhoneNumber,
        "message": message,
    };

}
