import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'add_professional_screen.dart';
import 'explanation_screen.dart';
import 'RegisterScreen.dart'; // Tela de Registro

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signOut(); // Garante que o usuário atual seja desconectado
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a senha';
    }
    return null;
  }

  // Função para login com Google
  Future<void> signInWithGoogle() async {
    try {
      // Inicia o processo de login com Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // O login foi cancelado pelo usuário
        print("Login com Google cancelado.");
        return;
      }

      // Obtém as credenciais de autenticação do Google
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // Verifica se googleAuth não é nulo
      if (googleAuth == null) {
        print("Erro: autenticação do Google falhou.");
        return;
      }

      // Cria credenciais do Firebase a partir das credenciais do Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Faz o login no Firebase com as credenciais do Google
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Exibe o nome do usuário autenticado
      print("Usuário logado: ${userCredential.user?.displayName}");

      // Navega para a tela de explicação após o login bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExplanationScreen()),
      );
    } catch (e) {
      print("Erro durante o login com Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Título da página
              Text(
                'Bem-vindo!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),

              // Input de Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _emailValidator,
              ),
              SizedBox(height: 16.0),

              // Input de Senha
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                validator: _passwordValidator,
              ),
              SizedBox(height: 24.0),

              // Botão de Login
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      // Autenticar com Firebase usando email e senha
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      // Navega para a tela de explicação após login bem-sucedido
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ExplanationScreen()),
                      );
                    } catch (e) {
                      // Tratar erro de autenticação
                      print("Erro durante o login: $e");
                    }
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 24.0),

              // Login com Google
              ElevatedButton.icon(
                onPressed: signInWithGoogle,
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                label: Text('Login com Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),

              // Link "Ainda não tenho uma conta"
              TextButton(
                onPressed: () {
                  // Navega para a tela de registro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Ainda não tenho uma conta',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
