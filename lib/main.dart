import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn_task1/authentication/presentation/login_screen.dart';
import 'package:provider/provider.dart';
import 'authentication/providers/auth_helper.dart';
import 'authentication/providers/provider_auth.dart';
import 'constants/colors.dart';
import 'news_feed/presentation/news_screen.dart';
import 'news_feed/provider/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationHelper authenticationHelper = AuthenticationHelper();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary, primary: primary, secondary: secondary,),
          useMaterial3: true,
        ),
        home: authenticationHelper.user == null ? const LoginScreen() :const NewsScreen(),
      ),
    );
  }
}
