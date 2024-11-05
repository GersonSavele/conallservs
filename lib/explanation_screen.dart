import 'package:flutter/material.dart';
import 'add_professional_screen.dart'; // Importa a tela de adicionar profissional
import 'service_list_screen.dart'; // Importa a tela de lista de serviços

class ExplanationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha uma Opção'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Botão para abrir o popup de explicação (agora na parte superior)
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Como Funciona a Aplicação?'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              '1. Crie um perfil de profissional se você deseja adicionar seus serviços à nossa plataforma.',
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '2. Explore os serviços disponíveis caso você esteja à procura de algum tipo de serviço.',
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '3. Cada profissional possui um perfil com detalhes como o tipo de serviço, contacto e localização.',
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Fechar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Como Funciona a Aplicação?'),
            ),
            SizedBox(height: 24.0), // Espaço entre o botão e a imagem

            // Imagem centralizada
            Center(
              child: Image.asset(
                'lib/assets/tecnico.png',
                height: 280,
              ),
            ),
            SizedBox(height: 24.0),

            // Texto de Explicação
            Text(
              'Seja bem-vindo à nossa plataforma! Aqui você pode criar um perfil de profissional e adicionar seus serviços ou explorar os serviços disponíveis.',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),

            // Botão para Criar Perfil de Profissional
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProfessionalScreen()),
                );
              },
              child: Text('Criar Perfil de Profissional'),
            ),
            SizedBox(height: 22.0),

            // Botão para Ver Serviços Disponíveis
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceListScreen()),
                );
              },
              child: Text('Ver Serviços Disponíveis'),
            ),
          ],
        ),
      ),
    );
  }
}
