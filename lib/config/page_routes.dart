import 'package:vems/pages/about_us/about_us_page.dart';
import 'package:vems/pages/authentication/forgot_password/forgot_password_page.dart';
import 'package:vems/pages/authentication/forgot_password/otp_page.dart';
import 'package:vems/pages/authentication/forgot_password/update_password_page.dart';
import 'package:vems/pages/authentication/intro/intro_page.dart';
import 'package:vems/pages/authentication/login/login_page.dart';
import 'package:vems/pages/authentication/onboarding/avatar_selection_page.dart';
import 'package:vems/pages/authentication/onboarding/choose_course_page.dart';
import 'package:vems/pages/authentication/onboarding/choose_institution_page.dart';
import 'package:vems/pages/authentication/onboarding/choose_mode_page.dart';
import 'package:vems/pages/authentication/onboarding/parent_onboarding_page.dart';
import 'package:vems/pages/authentication/onboarding/personal_info_page.dart';
import 'package:vems/pages/authentication/signup/signup_page.dart';
import 'package:vems/pages/authentication/signup/verify_email_page.dart';
import 'package:vems/pages/authentication/welcome/welcome_page.dart';
import 'package:vems/pages/chapters/chapters_page.dart';
import 'package:vems/pages/class_schedule/class_schedule_page.dart';
import 'package:vems/pages/contact_us/contact_us_page.dart';
import 'package:vems/pages/dashboard/dashboard_page.dart';
import 'package:vems/pages/dashboard/pages/exams/exams_page.dart';
import 'package:vems/pages/dashboard/pages/profile/profile_page.dart';
import 'package:vems/pages/dashboard/pages/profile/profile_root_page.dart';
import 'package:vems/pages/exams/exam_details_page.dart';
import 'package:vems/pages/exams/exam_questions_page.dart';
import 'package:vems/pages/exams/exam_results_page.dart';
import 'package:vems/pages/faq/faqs_page.dart';
import 'package:vems/pages/pending_request/pending_request_page.dart';
import 'package:vems/pages/privacy_policy/privacy_policy_page.dart';
import 'package:vems/pages/splash_screen/splash_screen_page.dart';
import 'package:vems/pages/terms_conditions/terms_conditions_page.dart';
import 'package:vems/pages/units/units_page.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/16/2020 6:23 AM
///

mixin MyPageRoutes {
  static final routes = {
    SplashScreen.routeName: (context) => SplashScreen(),
    IntroPage.routeName: (context) => IntroPage(),
    WelcomePage.routeName: (context) => WelcomePage(),
    LoginPage.routeName: (context) => LoginPage(),
    SignUpPage.routeName: (context) => SignUpPage(),
    VerifyEmailPage.routeName: (context) => VerifyEmailPage(),
    ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
    OTPPage.routeName: (context) => OTPPage(),
    UpdatePasswordPage.routeName: (context) => UpdatePasswordPage(),
    PersonalInfoPage.routeName: (context) => PersonalInfoPage(),
    ChooseInstitutionPage.routeName: (context) => ChooseInstitutionPage(),
    ChooseCoursePage.routeName: (context) => ChooseCoursePage(),
    ChooseAttendanceModePage.routeName: (context) => ChooseAttendanceModePage(),
    PendingRequestPage.routeName: (context) => PendingRequestPage(),
    DashboardPage.routeName: (context) => DashboardPage(),
    UnitsPage.routeName: (context) => UnitsPage(),
    ChaptersPage.routeName: (context) => ChaptersPage(),
    ClassSchedulePage.routeName: (context) => ClassSchedulePage(),
    ExamDetailsPage.routeName: (context) => ExamDetailsPage(),
    ExamQuestionsPage.routeName: (context) => ExamQuestionsPage(),
    ExamResultPage.routeName: (context) => ExamResultPage(),
    ProfilePage.routeName: (context) => ProfilePage(),
    AboutUsPage.routeName: (context) => AboutUsPage(),
    ContactUsPage.routeName: (context) => ContactUsPage(),
    TermsConditionsPage.routeName: (context) => TermsConditionsPage(),
    PrivacyPolicyPage.routeName: (context) => PrivacyPolicyPage(),
    FAQsPage.routeName: (context) => FAQsPage(),
    ExamsPage.routeName: (context) => ExamsPage(),
    ProfileRootPage.routeName: (context) => ProfileRootPage(),
    ParentOnboardingPage.routeName: (context) => ParentOnboardingPage(),
    AvatarSelectionPage.routeName: (context) => AvatarSelectionPage(),
  };
}
