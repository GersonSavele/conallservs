import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  final Map<String, String> service;

  ContactScreen({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Fornecedor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(service['profileImage']!),
                  radius: 50.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['professional']!,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Contacto: ${service['contact']}'),
                      Text('Localização: ${service['location']}'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Descrição:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(service['description']!),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Adicione a funcionalidade de contato aqui
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Funcionalidade de contato não implementada')),
                );
              },
              child: Text('Enviar Mensagem'),
            ),
          ],
        ),
      ),
    );
  }
}
