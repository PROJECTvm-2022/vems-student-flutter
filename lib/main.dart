import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:vems/bloc_models/assignment_details_bloc/index.dart';
import 'package:vems/bloc_models/assignments_bloc/assignments_bloc.dart';
import 'package:vems/bloc_models/assignments_bloc/upcoming_assignments_bloc/index.dart';
import 'package:vems/bloc_models/chapters_bloc/index.dart';
import 'package:vems/bloc_models/comments_bloc/comments_bloc.dart';
import 'package:vems/bloc_models/exam_bloc/exam_details_bloc/exam_details_bloc.dart';
import 'package:vems/bloc_models/exam_bloc/exams_bloc/index.dart';
import 'package:vems/bloc_models/exam_bloc/upcoming_exam_bloc/index.dart';
import 'package:vems/bloc_models/faq_bloc/index.dart';
import 'package:vems/bloc_models/live_class_bloc/index.dart';
import 'package:vems/bloc_models/live_quize_bloc/index.dart';
import 'package:vems/bloc_models/material_details_bloc/index.dart';
import 'package:vems/bloc_models/materials_bloc/index.dart';
import 'package:vems/bloc_models/profile_bloc/index.dart';
import 'package:vems/bloc_models/profile_stats_bloc/index.dart';
import 'package:vems/bloc_models/quiz_result_bloc/index.dart';
import 'package:vems/bloc_models/related_videos_bloc/index.dart';
import 'package:vems/bloc_models/reply_bloc/reply_bloc.dart';
import 'package:vems/bloc_models/schedule_bloc/index.dart';
import 'package:vems/bloc_models/subjects_bloc/index.dart';
import 'package:vems/bloc_models/units_bloc/all_units_bloc/index.dart';
import 'package:vems/bloc_models/units_bloc/index.dart';
import 'package:vems/bloc_models/video_history_bloc/index.dart';
import 'package:vems/bloc_models/video_questions_bloc/index.dart';
import 'package:vems/bloc_models/videos_bloc/index.dart';
import 'package:vems/config/index.dart';
import 'package:vems/config/page_routes.dart';
import 'package:vems/pages/splash_screen/splash_screen_page.dart';
import 'package:vems/utils/notification_services/in_app_notification.dart';
import 'package:vems/utils/offline_library_helper.dart';
import 'package:vems/utils/security_helper.dart';
import 'package:vems/utils/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'bloc_models/chapters_bloc/all_chapters_bloc/index.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = SimpleBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();
  OfflineLibraryHelper.openDB();
  // OfflineLibraryHelper.deleteDb();

  /// Setup for notification services
  InAppNotification.configureInAppNotification();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => SubjectsBloc()),
    BlocProvider(create: (context) => UnitsBloc()),
    BlocProvider(create: (context) => ChaptersBloc()),
    BlocProvider(create: (context) => VideosBloc()),
    BlocProvider(create: (context) => CommentsBloc()),
    BlocProvider(create: (context) => ReplyBloc()),
    BlocProvider(create: (context) => VideoQuestionsBloc()),
    BlocProvider(create: (context) => ScheduleBloc()),
    BlocProvider(create: (context) => ProfileBloc()),
    BlocProvider(create: (context) => LiveClassBloc()),
    BlocProvider(create: (context) => ExamsBloc()),
    BlocProvider(create: (context) => ExamDetailsBloc()),
    BlocProvider(create: (context) => UpcomingExamsBloc()),
    BlocProvider(create: (context) => VideoHistoryBloc()),
    BlocProvider(create: (context) => ProfileStatsBloc()),
    BlocProvider(create: (context) => FAQBloc()),
    BlocProvider(create: (context) => LiveQuizBloc()),
    BlocProvider(create: (context) => QuizResultBloc()),
    BlocProvider(create: (context) => MaterialsBloc()),
    BlocProvider(create: (context) => AllUnitsBloc()),
    BlocProvider(create: (context) => AllChaptersBloc()),
    BlocProvider(create: (context) => MaterialsDetailsBloc()),
    BlocProvider(create: (context) => RelatedVideosBloc()),
    BlocProvider(create: (context) => AssignmentBloc()),
    BlocProvider(create: (context) => AssignmentDetailsBloc()),
    BlocProvider(create: (context) => UpcomingAssignmentBloc()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    InAppNotification.requestIOSPermissions();
    SecurityHelper.enableSecurity();
  }

  @override
  void dispose() {
    SubjectsBloc().close();
    UnitsBloc().close();
    ChaptersBloc().close();
    VideosBloc().close();
    CommentsBloc().close();
    ReplyBloc().close();
    VideoQuestionsBloc().close();
    ScheduleBloc().close();
    ProfileBloc().close();
    LiveClassBloc().close();
    ExamsBloc().close();
    ExamDetailsBloc().close();
    UpcomingExamsBloc().close();
    VideoHistoryBloc().close();
    ProfileStatsBloc().close();
    FAQBloc().close();
    LiveQuizBloc().close();
    QuizResultBloc().close();
    MaterialsBloc().close();
    AllUnitsBloc().close();
    AllChaptersBloc().close();
    MaterialsDetailsBloc().close();
    RelatedVideosBloc().close();
    AssignmentBloc().close();
    AssignmentDetailsBloc().close();
    UpcomingAssignmentBloc().close();
    SecurityHelper.disableSecurity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VEMS',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: MyThemes.lightThemeData,
      darkTheme: MyThemes.darkThemeData,
      themeMode: ThemeMode.system,
      initialRoute: SplashScreen.routeName,
      routes: MyPageRoutes.routes,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
