import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'AdicionarServicoScreen.dart'; // Certifique-se de que este import está correto

class AddProfessionalScreen extends StatefulWidget {
  @override
  _AddProfessionalScreenState createState() => _AddProfessionalScreenState();
}

class _AddProfessionalScreenState extends State<AddProfessionalScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedArea;
  final List<String> _areas = [
    'Canalização',
    'Carpintaria',
    'Serralharia',
    'Reparação de Eletrodomésticos',
    'Limpeza',
    'Jardinagem',
    'Pintura',
    'Eletricista',
    'Encanação',
    'Outros',
  ];

  XFile? _biImage;
  List<XFile>? _serviceImages = [];
  XFile? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickBIImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _biImage = pickedImage;
    });
  }

  Future<void> _pickServiceImages() async {
    final pickedImages = await _picker.pickMultiImage();
    setState(() {
      _serviceImages = pickedImages;
    });
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Profissional'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField(
                label: 'Nome do Profissional',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do profissional';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              _buildDropdownField(
                label: 'Área de Atuação',
                value: _selectedArea,
                items: _areas,
                onChanged: (value) {
                  setState(() {
                    _selectedArea = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma área de atuação';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              _buildTextField(
                label: 'Contacto(+258)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o contato';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              _buildTextField(
                label: 'Localização',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a localização';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              _buildTextField(
                label: 'Descrição do Serviço',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do serviço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              _buildImagePicker(
                label: 'Foto do BI',
                image: _biImage,
                onPressed: _pickBIImage,
              ),
              SizedBox(height: 16.0),

              _buildImagePicker(
                label: 'Foto de Perfil',
                image: _profileImage,
                onPressed: _pickProfileImage,
              ),
              SizedBox(height: 24.0),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Dados salvos com sucesso!')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddServiceScreen()),
                    );
                  }
                },
                child: Text('Salvar'),
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
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
    required FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildImagePicker({
    required String label,
    XFile? image,
    List<XFile>? images,
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
            ? _buildImagePreview(image)
            : images != null && images.isNotEmpty
            ? _buildImagesPreview(images)
            : ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.add_a_photo),
          label: Text('Adicionar Imagem'),
        ),
      ],
    );
  }

  Widget _buildImagePreview(XFile image) {
    return Card(
      child: Image.file(
        File(image.path),
        height: 150.0,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildImagesPreview(List<XFile> images) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: images.map((image) {
        return _buildImagePreview(image);
      }).toList(),
    );
  }
}