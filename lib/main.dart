import 'dart:io';
import 'package:docmehr/application/blocs/userInfo/user_info_bloc.dart';
import 'package:docmehr/infrastructure/userInfoRepo.dart';
import 'package:docmehr/presentation/screens/login.dart';
import 'package:docmehr/presentation/screens/profile.dart';
import 'package:docmehr/presentation/screens/punching.dart';
import 'package:flutter/material.dart';
import 'package:docmehr/presentation/screens/dashboard.dart';
import 'package:docmehr/presentation/screens/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<UserInfoRepo>(
          create: (context) => UserInfoRepo(),
        ),
        BlocProvider(
          create: (context) => UserInfoBloc(
            context.read<UserInfoRepo>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Benchmark WFM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: Profile(),
        initialRoute: Splash.routeName,
        routes: {
          Splash.routeName: (ctx) => const Splash(),
          DashBoard.routeName: (ctx) => const DashBoard(),
          Login.routeName: (ctx) => const Login(),
        },
      ),
    );
  }
}
