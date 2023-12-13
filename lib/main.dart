import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/pages.dart';
import 'services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

//Aqui se Delfine las rutas de la aplicación y sus correspondientes widgets.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BBQ',
      initialRoute: 'checking',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(),
        'checking': (_) => CheckAuthScreen()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.orange,
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.brown),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.brown, elevation: 0)),
    );
  }
}