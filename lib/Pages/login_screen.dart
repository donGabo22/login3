import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../services/services.dart';
import '../ui/ui.dart';
import '../widgets/widgets.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 250),
//               CardContainer(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     Text('Bienvenido a BBQ',
//                         style: Theme.of(context).textTheme.headline4),
//                     const SizedBox(height: 30),
//                     ChangeNotifierProvider(
//                       create: (_) => LoginFormProvider(),
//                       child: _LoginForm(),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 50),
//               TextButton(
//                 onPressed: () =>
//                     Navigator.pushReplacementNamed(context, 'register'),
//                 style: ButtonStyle(
//                   overlayColor:
//                       MaterialStateProperty.all(Colors.brown.withOpacity(0.1)),
//                   shape: MaterialStateProperty.all(StadiumBorder()),
//                   backgroundColor: MaterialStateProperty.all(Colors.brown),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(15),
//                   child: const Text(
//                     'Crear una nueva cuenta',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _LoginForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final loginForm = Provider.of<LoginFormProvider>(context);

//     return Container(
//       child: Form(
//         key: loginForm.formKey,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         child: Column(
//           children: [
//             TextFormField(
//               autocorrect: false,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecorations.authInputDecoration(
//                 hintText: 'john.doe@gmail.com',
//                 labelText: 'Correo electrónico',
//                 prefixIcon: Icons.alternate_email_rounded,
//               ),
//               onChanged: (value) => loginForm.email = value,
//               validator: (value) {
//                 String pattern =
//                     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                 RegExp regExp = new RegExp(pattern);

//                 return regExp.hasMatch(value ?? '')
//                     ? null
//                     : 'El valor ingresado no luce como un correo';
//               },
//             ),
//             const SizedBox(height: 30),
//             TextFormField(
//               autocorrect: false,
//               obscureText: true,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecorations.authInputDecoration(
//                 hintText: '*****',
//                 labelText: 'Contraseña',
//                 prefixIcon: Icons.lock_outline,
//               ),
//               onChanged: (value) => loginForm.password = value,
//               validator: (value) {
//                 return (value != null && value.length >= 6)
//                     ? null
//                     : 'La contraseña debe de ser de 6 caracteres';
//               },
//             ),
//             const SizedBox(height: 30),
//             MaterialButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.grey,
//               elevation: 0,
//               color: Colors.brown,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                 child: Text(
//                   loginForm.isLoading ? 'Espere' : 'Ingresar',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               onPressed: loginForm.isLoading
//                   ? null
//                   : () async {
//                       FocusScope.of(context).unfocus();
//                       final authService =
//                           Provider.of<AuthService>(context, listen: false);

//                       if (!loginForm.isValidForm()) return;

//                       loginForm.isLoading = true;

//                       // TODO: validar si el login es correcto
//                       final String? errorMessage = await authService.login(
//                           loginForm.email, loginForm.password);

//                       if (errorMessage == null) {
//                         Navigator.pushReplacementNamed(context, 'home');
//                       } else {
//                         // TODO: mostrar error en pantalla
//                         // print( errorMessage );
//                         NotificationsService.showSnackbar(errorMessage);
//                         loginForm.isLoading = false;
//                       }
//                     },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/login_form_provider.dart';
// import '../services/services.dart';
// import '../ui/ui.dart';
// import '../widgets/widgets.dart';









class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Icono grande en la parte superior izquierda
        leading: Icon(
          Icons.account_circle,
          size: 40.0,
        ),
        title: Text('Inicio de Sesión'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50), // Ajusté el espacio aquí
              CardContainer(
                child: Column(
                  children: [
                    Text('Bienvenido a BBQ',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 200), // Ajusté el espacio aquí
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.brown.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(Colors.brown),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: const Text(
                    'Crear una nueva cuenta',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.brown,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      // TODO: validar si el login es correcto
                      final String? errorMessage = await authService.login(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // TODO: mostrar error en pantalla
                        // print( errorMessage );
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
