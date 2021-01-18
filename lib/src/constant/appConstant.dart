class AppConstant {
  static String baseUrl = 'https://sidmachocr.azurewebsites.net/';
  static String userLoginEndpoint = 'Account/OAuthLoginAsync/';
  static String postFormEndpoint = 'api/External/PostForm/';
  static String getResultEndpoint = 'api/External/GetFormByUrl/';
  static String saveResultEndpoint = 'api/External/SaveForm/';
  static String auditTrailEndpoint = 'api/External/GetAuditTrail';
  static String workFlowEndpoint = 'api/External/WorkFlow';
  static String savedFormsEndpoint = 'api/External/GetSavedForms';
  static String allUserFormsEndpoint = 'api/External/GetAllUserForms';
}