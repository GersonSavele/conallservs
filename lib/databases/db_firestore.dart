import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  get name_bi => null;

  get name_profile => null;

  // Função para criar um profissional no Firestore
  Future<void> createProfessional({
    required String name,
    required String area,
    required String contact,
    required String location,
    required String serviceDescription,
    File? biImage,
    File? profileImage,
    List<File>? serviceImages,
  }) async {
    try {
      // Upload das imagens
      String? biImageUrl;
      String? profileImageUrl;
      List<String> serviceImageUrls = [];

      // Upload da imagem do BI se existir
      if (biImage != null) {
        biImageUrl = await _uploadImage(biImage, 'bi_images/$name_bi.jpg');
      }

      // Upload da imagem de perfil se existir
      if (profileImage != null) {
        profileImageUrl =
        await _uploadImage(profileImage, 'profile_images/$name_profile.jpg');
      }

      // Upload das imagens de serviços se existirem
      if (serviceImages != null) {
        for (File image in serviceImages) {
          String imageUrl = await _uploadImage(image, 'service_images/$name/${image.path.split('/').last}');
          serviceImageUrls.add(imageUrl);
        }
      }

      // Criar documento no Firestore
      await _firestore.collection('professionals').add({
        'name': name,
        'area': area,
        'contact': contact,
        'location': location,
        'serviceDescription': serviceDescription,
        'biImageUrl': biImageUrl,
        'profileImageUrl': profileImageUrl,
        'serviceImages': serviceImageUrls,
      });

      print("Profissional criado com sucesso no Firestore!");
    } catch (e) {
      print("Erro ao criar profissional no Firestore: $e");
    }
  }

  // Função auxiliar para upload de imagem
  Future<String> _uploadImage(File file, String path) async {
    try {
      // Referência ao local de armazenamento no Firebase Storage
      final Reference storageRef = _storage.ref().child(path);

      // Upload do arquivo
      UploadTask uploadTask = storageRef.putFile(file);

      // Esperar a conclusão do upload
      TaskSnapshot snapshot = await uploadTask;

      // Retornar a URL da imagem
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Erro ao fazer upload de imagem: $e");
      throw e;
    }
  }

  createUser(String uid, String text, String text2) {}
}
