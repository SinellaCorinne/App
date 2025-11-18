


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noworry_app/data/models/country.dart';
import 'package:noworry_app/theme/styles.dart';

class MinimalPhoneField extends StatefulWidget {
  final String initialCountryCode;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String hintText;

  const MinimalPhoneField({
    super.key,
    this.initialCountryCode = 'SN', // Défaut Sénégal
    this.onChanged,
    this.validator,
    this.controller,
    required this.hintText,
  });

  @override
  State<MinimalPhoneField> createState() => _MinimalPhoneFieldState();
}

class _MinimalPhoneFieldState extends State<MinimalPhoneField> {
  late MinimalCountry _selectedCountry;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    
    _focusNode = FocusNode();

    // Ajout du listener pour déclencher setState lors du changement de focus
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {}); 
      }
    });
    
    // Trouver le pays initial
    // Attention: 'minimalCountries' doit être accessible ici (via l'import de 'country.dart')
    _selectedCountry = minimalCountries.firstWhere(
      (country) => country.code == widget.initialCountryCode,
      orElse: () => minimalCountries.first,
    );
    
    // Si le contrôleur est vide, pré-remplir le code du pays dans le champ
    if (_controller.text.isEmpty) {
        _controller.text = _selectedCountry.dialCode;
    }
  }

  @override
  void dispose() {
    // ⚠️ CORRECTION CRITIQUE: Suppression du FocusNode et de son listener
    _focusNode.removeListener(() {
      if (mounted) {
        setState(() {}); 
      }
    });
    _focusNode.dispose();

    // Si nous avons créé le contrôleur en interne, nous le disposons
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
  
  // Ouvre le sélecteur de pays
  void _openCountryPickerDialog() async {
    final selected = await showDialog<MinimalCountry>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Sélectionner un pays'),
          children: minimalCountries.map((country) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, country);
              },
              child: Row(
                children: [
                  Text(country.flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Text('${country.name} (+${country.dialCode})'),
                ],
              ),
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedCountry = selected;
        // Optionnel : Réinitialiser le champ au nouveau code pays
        _controller.text = selected.dialCode;
        // Placer le curseur à la fin du texte
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // La couleur de la bordure est gérée par focusedBorder dans l'InputDecoration
    // L'ancienne variable borderColor n'est plus strictement nécessaire si vous utilisez le focusedBorder
    // final Color borderColor = _focusNode.hasFocus ? AppColors.primary : AppColors.grayL; 

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode, // Attaché ici
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: KTypography.h6(context)?.copyWith(fontWeight: FontWeight.normal),
      
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: KTypography.h6(context, color:Colors.transparent),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        
        // Bordure par défaut (non focalisée)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        
        // Bordure focalisée (couleur principale)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),

        // ✅ L'élément clé : le drapeau seul comme prefixIcon
        prefixIcon: InkWell(
          onTap: _openCountryPickerDialog,
          child: Container(
            // Masque la ligne verticale par défaut en rendant le décor transparent
            decoration: const BoxDecoration(
              // Supprime la ligne de séparation verticale par défaut du prefixIcon
              border: Border(right: BorderSide(color: Colors.transparent)),
            ),
            padding: const EdgeInsets.only(left: 12, right: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Affichage du drapeau emoji
                Text(
                  _selectedCountry.flag,
                  style: const TextStyle(fontSize: 24),
                ),
                // Pas d'espace ni de code ici pour que le numéro s'affiche immédiatement
              ],
            ),
          ),
        ),
        // S'assurer que le prefixIcon n'a pas de padding supplémentaire non désiré
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
      ),
      
      onChanged: (value) {
        widget.onChanged?.call(value);
      },
      validator: widget.validator,
    );
  }
}