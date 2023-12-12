import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// AuthService maneja la autenticación del usuario 
// a través de solicitudes HTTP
class AuthService extends ChangeNotifier {
  // Solicitudes HTTP
  final String _baseUrl = 'http://www.loginghd.somee.com';
  final storage = FlutterSecureStorage();

  // Método para registrar un nuevo usuario
  Future<String?> createUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.parse('$_baseUrl/api/Cuentas/registrar');

    try {
      final resp = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData),
      );

      print('Respuesta del servidor: ${resp.body}');

      if (resp.statusCode == 200) {
        final Map<String, dynamic> decodedResp = json.decode(resp.body);

        if (decodedResp.containsKey('token')) {
          // Almacena el token en el almacenamiento seguro
          await storage.write(key: 'token', value: decodedResp['token']);
          return null;
        } else {
          return 'La respuesta del servidor no contiene un token';
        }
      } else {
        return 'Error en la solicitud: ${resp.reasonPhrase}';
      }
    } catch (e) {
      // Manejo de errores durante la solicitud
      print('Error en la solicitud: $e');
      return 'Error en la solicitud';
    }
  }

  // Método para iniciar sesión
  Future<String?> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.parse('$_baseUrl/api/Cuentas/Login');

    try {
      final resp = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData),
      );

      print('Respuesta del servidor: ${resp.body}');

      if (resp.statusCode == 200) {
        final Map<String, dynamic> decodedResp = json.decode(resp.body);

        if (decodedResp.containsKey('token')) {
          // Almacena el token en el almacenamiento seguro
          await storage.write(key: 'token', value: decodedResp['token']);
          return null;
        } else {
          return 'La respuesta del servidor no contiene un token';
        }
      } else {
        return 'Error en la solicitud: ${resp.reasonPhrase}';
      }
    } catch (e) {
      // Manejo de errores durante la solicitud
      print('Error en la solicitud: $e');
      print('Error en la solicitud a $url: $e');

      return 'Error en la solicitud';
    }
  }

  // Método para cerrar sesión
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  // Método para leer el token almacenado
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
