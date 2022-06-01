import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/common/widgets/bottom_nav_bar.dart';
import 'package:shopp/constants/global_variables.dart';
import 'package:shopp/features/admin/screens/admin_screen.dart';
import 'package:shopp/features/auth/screens/auth_screen.dart';
import 'package:shopp/features/auth/services/auth_service.dart';
import 'package:shopp/provider/user_provider.dart';
import 'package:shopp/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUSerData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kiishi\'s Ends',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: GlobalVariables.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomNavBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
