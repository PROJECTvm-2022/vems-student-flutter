///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 2:33 PM
///
mixin ApiRoutes {
  //static const baseUrl = 'https://api.jupionclasses.com';
  //static const baseUrl = 'https://api.vems.smarttersstudio.in';
  static const baseUrl = 'https://api.ems.vernacularmedium.com'
  //
  // static const baseUrl = 'http://192.168.29.96:3030'; //hotspot
  // static const baseUrl = 'http://192.168.165.19:3030'; // broadband
  static const upload = 'v1/upload-photo';
  static const googleLogin = 'v1/google-login';
  static const String geoCoderApi =
      'https://maps.googleapis.com/maps/api/geocode/json';
  static const String authentication = "authentication";
  static const String authenticationEmail = "v1/authenticate-email";
  static const String user = "v1/user";
  static const String signInWithSocialMedia = "social-login";
  static const String forgetPassword = "v1/forget-password";
  static const String verifyEmail = "v1/verify-email";
  static const String verifyResetOTP = "v1/verify-password-otp";
  static const String resetPassword = "v1/reset-password";
  static const String institute = "v1/institute";
  static const String instituteCourse = "v1/institute-course";
  static const String specialization = "v1/specialization";
  static const String seatAccess = "v1/student-seat";
  static const String subject = "v1/student-subjects";
  static const String unit = "v1/unit";
  static const String chapter = "v1/chapter";
  static const String video = "v1/student-video";
  static const String comment = "v1/comment";
  static const String question = "v1/question";
  static const String answer = "v1/student-video-answers";
  static const String timeTable = "v1/timetable";
  static const String liveClass = "v1/scheduled-live-class";
  static const String chat = "v1/chat";
  static const String exams = "v1/student-exam";
  static const String examAnswer = "v1/student-exam-answer";
  static const String studentProfile = "v1/student-profile";
  static const String contactUs = "v1/contact-us";
  static const String faq = "v1/faq";
  static const String zoomApi = "v1/generate-signature";
  static const String materials = "v1/material-drive";
  static const String relatedMaterialVideo = "v1/related-material-video";
  static const String studentAssignment = "v1/student-assignment";
  static const String parentVerification = "v1/parent-verification";
  static const String verifyParent = "v1/verify-parent";
  static const String feedback = "v1/live-class-feedback";
}
