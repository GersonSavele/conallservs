import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _serviceImage;
  final ImagePicker _picker = ImagePicker();
  String? _serviceDescription;

  Future<void> _pickServiceImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _serviceImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Serviço'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Campo para adicionar foto do serviço
              _buildImagePicker(
                label: 'Imagem do Serviço',
                image: _serviceImage,
                onPressed: _pickServiceImage,
              ),
              SizedBox(height: 16.0),

              // Input da Descrição do Serviço
              _buildTextField(
                label: 'Descrição do Serviço',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do serviço';
                  }
                  return null;
                },
                onChanged: (value) {
                  _serviceDescription = value;
                },
              ),
              SizedBox(height: 24.0),

              // Botão para Salvar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    // Ação para salvar os dados
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Serviço adicionado com sucesso!')),
                    );
                  }
                },
                child: Text('Salvar Serviço'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    required FormFieldValidator<String>? validator,
    required ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildImagePicker({
    required String label,
    XFile? image,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        image != null
            ? Card(
          child: Image.file(
            File(image.path),
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        )
            : ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.add_a_photo),
          label: Text('Adicionar Imagem'),
        ),
      ],
    );
  }
}
