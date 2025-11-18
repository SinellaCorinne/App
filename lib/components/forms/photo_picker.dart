import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:noworry_app/theme/styles.dart'; // Pour utiliser File

class PhotoPickerComponent extends StatefulWidget {
  const PhotoPickerComponent({super.key});

  @override
  State<PhotoPickerComponent> createState() => _PhotoPickerComponentState();
}

class _PhotoPickerComponentState extends State<PhotoPickerComponent> {
  // Liste pour stocker les chemins des images sélectionnées par l'utilisateur
  // Nous utiliserons 'File' pour les images locales
  List<File> _selectedImages = [];

  // Fonction pour ouvrir le sélecteur de fichiers
  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true, // Permet de sélectionner plusieurs images
      );

      if (result != null) {
        setState(() {
          // Convertit les PlatformFile en dart:io.File et les ajoute à la liste
          _selectedImages.addAll(result.files.map((file) => File(file.path!)).toList());
        });
      }
    } catch (e) {
      // Gérer l'erreur (ex: l'utilisateur a annulé, ou autre problème)
      print("Erreur lors de la sélection des images: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Zone d'ajout de photos (Le composant en pointillés)
          _buildAddPhotoArea(context),

          if (_selectedImages.isNotEmpty) ...[
            const SizedBox(height: 16),
            // 2. Grille des photos sélectionnées
            _buildPhotoGrid(),
          ],
        ],
      ),
    );
  }
  
  // Widget pour la zone d'ajout
  Widget _buildAddPhotoArea(BuildContext context) {
    const Color primaryColor = Colors.black87; 

    return InkWell(
      onTap: _pickImages, // Appelle notre fonction de sélection d'images
      borderRadius: BorderRadius.circular(8),
      child: DottedBorder(

        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 12),
        dashPattern: const [8, 4],
        color: AppColors.grayL,
        strokeWidth: 2,
        child:  Center(
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Container(decoration:BoxDecoration(
                border: Border.all(color: Colors.black),
             shape: BoxShape.circle,
             color: Colors.black
              ) ,
                child: Icon(Icons.add, size: 18, color: Colors.white)),
              const SizedBox(width: 10),
              const Text(
                'Ajouter des photos',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour la grille des photos sélectionnées
  Widget _buildPhotoGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 colonnes
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: _selectedImages.length,
      itemBuilder: (context, index) {
        // Utilise Image.file pour afficher une image à partir d'un chemin de fichier local
        return ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.file(
            _selectedImages[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}