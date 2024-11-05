import 'package:flutter/material.dart';
import 'ContactScreen.dart'; // Certifique-se de que este import está correto

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  final List<Map<String, String>> services = [
    {
      'image': 'lib/assets/carpentry.jpg',
      'title': 'Serviço de Carpintaria',
      'description': 'Montagem de móveis e consertos.',
      'professional': 'João da Silva',
      'contact': '+258 84 123 4567',
      'location': 'Maputo, Moçambique',
      'profileImage': 'lib/assets/joao.jpg',
      'category': 'Carpintaria',
    },
    {
      'image': 'lib/assets/cleaning.jpeg',
      'title': 'Serviço de Limpeza',
      'description': 'Limpeza residencial e comercial.',
      'professional': 'Maria Fernandes',
      'contact': '+258 82 987 6543',
      'location': 'Matola, Moçambique',
      'profileImage': 'lib/assets/maria.jpg',
      'category': 'Limpeza',
    },
    {
      'image': 'lib/assets/electric.jpg',
      'title': 'Serviço de Eletricista',
      'description': 'Reparação e instalação elétrica.',
      'professional': 'Carlos Mendes',
      'contact': '+258 84 654 3210',
      'location': 'Beira, Moçambique',
      'profileImage': 'lib/assets/carlos.jpg',
      'category': 'Eletricidade',
    },
    {
      'image': 'lib/assets/plumbing.jpg',
      'title': 'Serviço de Canalização',
      'description': 'Instalação e reparos hidráulicos.',
      'professional': 'Manuel Joaquim',
      'contact': '+258 82 456 7890',
      'location': 'Nampula, Moçambique',
      'profileImage': 'lib/assets/manuel.jpg',
      'category': 'Canalização',
    },
    {
      'image': 'lib/assets/gardening.jpg',
      'title': 'Serviço de Jardinagem',
      'description': 'Corte de grama e manutenção de jardins.',
      'professional': 'Ana Lopes',
      'contact': '+258 84 567 1234',
      'location': 'Inhambane, Moçambique',
      'profileImage': 'lib/assets/ana.jpg',
      'category': 'Jardinagem',
    },
    {
      'image': 'lib/assets/painting.jpg',
      'title': 'Serviço de Pintura',
      'description': 'Pintura de interiores e exteriores.',
      'professional': 'Pedro Gonçalves',
      'contact': '+258 82 789 0123',
      'location': 'Xai-Xai, Moçambique',
      'profileImage': 'lib/assets/pedro.jpg',
      'category': 'Pintura',
    },
    {
      'image': 'lib/assets/repair.jpg',
      'title': 'Reparação de Eletrodomésticos',
      'description': 'Reparo de geladeiras, máquinas de lavar, etc.',
      'professional': 'Francisco Dias',
      'contact': '+258 84 345 6789',
      'location': 'Quelimane, Moçambique',
      'profileImage': 'lib/assets/francisco.jpg',
      'category': 'Reparos',
    },
    {
      'image': 'lib/assets/flooring.jpg',
      'title': 'Serviço de Pisos e Azulejos',
      'description': 'Instalação de pisos e azulejos.',
      'professional': 'Adriana Neves',
      'contact': '+258 82 987 6543',
      'location': 'Pemba, Moçambique',
      'profileImage': 'lib/assets/adriana.jpg',
      'category': 'Construção',
    },
    {
      'image': 'lib/assets/security.jpg',
      'title': 'Instalação de Sistemas de Segurança',
      'description': 'Instalação de câmeras e alarmes.',
      'professional': 'Miguel Santos',
      'contact': '+258 84 234 5678',
      'location': 'Tete, Moçambique',
      'profileImage': 'lib/assets/miguel.jpg',
      'category': 'Segurança',
    },
  ];

  final List<String> categories = [
    'Todos',
    'Carpintaria',
    'Limpeza',
    'Eletricidade',
    'Canalização',
    'Jardinagem',
    'Pintura',
    'Reparos',
    'Construção',
    'Segurança',
  ];

  String selectedCategory = 'Todos';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredServices = services.where((service) {
      final matchesCategory =
          selectedCategory == 'Todos' || service['category'] == selectedCategory;
      final matchesQuery = searchQuery.isEmpty ||
          service['title']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços Disponíveis'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      labelText: 'Pesquisar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Adicione lógica para abrir uma tela de filtro, se necessário
                  },
                  child: Text('Pesquisar'),
                ),
              ],
            ),
          ),
          Container(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true, // Para mostrar a barra de rolagem
              child: ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        service['image']!.isNotEmpty
                            ? Image.asset(service['image']!)
                            : Container(
                          height: 150,
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              'Sem imagem disponível',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                service['title']!,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(service['description']!),
                              SizedBox(height: 10.0),
                              Text('Profissional: ${service['professional']}'),
                              Text('Contacto: ${service['contact']}'),
                              Text('Localização: ${service['location']}'),
                              SizedBox(height: 10.0),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ContactScreen(service: service),
                                      ),
                                    );
                                  },
                                  child: Text('Contactar'),
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
