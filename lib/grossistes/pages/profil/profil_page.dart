import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage ({super.key});

  @override
  State<ProfilPage > createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage > {
  // Simuler les données initiales
  final String _firstName = "Wakiou";
  final String _lastName = "Farr";
  final String _phoneNumber = "+22170908900";
  
  // Contrôleurs pour les champs de saisie
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs avec les données utilisateur
    _firstNameController.text = _firstName;
    _lastNameController.text = _lastName;
    _phoneController.text = _phoneNumber;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleSave(AppLocalizations l10n) {
     // Logique pour sauvegarder les données
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.saveButton} réussi !')),
      );
  }

  // Widget réutilisable pour les champs de saisie (utilisé dans les pages précédentes)
  Widget _buildInfoTextField(String placeholder, TextEditingController controller, {bool isReadOnly = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.grayL, width: 0.5),
      ),
      child: TextField(
        controller: controller,
  
        decoration: InputDecoration(
          hintText: placeholder,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        style:KTypography.k9(context, )?.copyWith(fontWeight: FontWeight.w300),
         
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
     
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(width: 60),
            // --- Header (Image, Nom, K-Icon) ---
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:ExactAssetImage('assets/images/profil.jpg'), // Image de profil simulée
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_firstName $_lastName',
                      style:  KTypography.h5(context, ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      _phoneNumber,
                      style: KTypography.h6(context, color: AppColors.grayD),
                    ),
                  ],
                ),
    
                
              ],
            ),
            
            const SizedBox(height: 30),

            // --- Section 1: Information personnelle ---
            Text(
              l10n.personalInfoTitle, // 🔑 Traduction: "Information personnelle"
              style: KTypography.k9(context, )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            
            _buildInfoTextField(l10n.firstNameLabel, _firstNameController), // 🔑 Traduction du placeholder
            _buildInfoTextField(l10n.lastNameLabel, _lastNameController),   // 🔑 Traduction du placeholder
            _buildInfoTextField(_phoneNumber, _phoneController, isReadOnly: true),

            const SizedBox(height: 24),

            // --- Section 2: Adresse ---
            Text(
              l10n.addressLabel, // 🔑 Traduction: "Adresse"
              style: KTypography.k9(context, )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            
            // Champ de texte multiligne pour l'adresse
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
               
                border: Border.all(color:AppColors.grayL, width: 0.5),
              ),
              child: TextField(
                controller: _addressController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            
            const SizedBox(height: 60),

            // --- Bouton Sauvegarder ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleSave(l10n),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                
                ),
                child: Text(
                  l10n.saveButton, // 🔑 Traduction: "Sauvegarder"
                  style: KTypography.k9(context, color: Colors.white)?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),

     
    );
  }
}