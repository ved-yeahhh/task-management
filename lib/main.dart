import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/bloc/auth/auth_bloc.dart';
import 'package:task_mgmt/bloc/task/task_bloc.dart';
import 'package:task_mgmt/common/hex_colors.dart';
import 'package:task_mgmt/data/repository/auth_repository.dart';
import 'package:task_mgmt/data/repository/task_repository.dart';
import 'package:task_mgmt/presentation/screens/add_task_page.dart';
import 'package:task_mgmt/presentation/screens/home_screen.dart';
import 'package:task_mgmt/presentation/screens/login_screen.dart';
import 'package:task_mgmt/presentation/screens/profile.dart';
import 'package:task_mgmt/presentation/screens/signup_page.dart';
import 'package:task_mgmt/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(FirebaseAuthRepository())),
        BlocProvider(create: (_) => TaskBloc(TaskRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: HexColor(HexColors.greenLight),
          scaffoldBackgroundColor: HexColor(HexColors.neutrals20),

          appBarTheme: AppBarTheme(
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            backgroundColor: HexColor(HexColors.primary10),
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          // cardTheme: CardThemeData(
          //   color: HexColor(HexColors.neutrals10),
          //   margin: EdgeInsets.all(8),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(12)),
          //   ),
          // ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          textTheme: const TextTheme(
            titleSmall: TextStyle(fontSize: 12.0, color: Colors.white),
            titleMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const LoginScreen(),
          "/signup": (context) => SignupPage(),
          "/home": (context) => HomeScreen(),
          "/addTask": (context) => AddTaskPage(),
          "/profile": (context) => ProfileScreen(),
          "/login": (context) => LoginScreen(),
        },
      ),
    );
  }
}
