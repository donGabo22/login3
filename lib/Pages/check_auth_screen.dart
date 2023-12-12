import 'package:flutter/material.dart';
import 'package:login3/services/auth_services.dart';
import 'package:provider/provider.dart';
// Importaciones adicionales necesarias
import '../services/services.dart';
import 'pages.dart';
// Widget encargado de verificar la autenticación del usuario
// y redirigirlo a la pantalla de inicio de sesión o a la 
// pantalla principal en función de si se ha iniciado sesión o no.
class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener una instancia del servicio de autenticación
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          // Leer el token amlacendo
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text('');
            if (snapshot.data == '') {
              Future.microtask(() {
                 Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            } 
            // Si hay un token, redirigir a la pantalla principal
            else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
