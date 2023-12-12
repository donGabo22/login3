// unused_page.dart
import 'package:flutter/material.dart';

class UnusedPage extends StatelessWidget {
  const UnusedPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      alignment: Alignment.center,
      child: const Text('Page 3: Aquí debería consumir las recientes o favoritos o algo así'),
    );
  }
}
