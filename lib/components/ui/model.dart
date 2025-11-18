import 'package:flutter/material.dart';
import 'package:noworry_app/components/layout/layout.dart';
import '../../theme/styles.dart';


class Model extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Widget? action;
  final Widget? indicator; // Correctement défini

 Model(
      { super.key,
        required this.title,
        required this.description,
        required this.image,
        this.action,
        this.indicator});


  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "",
      subtitle: "",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
             const SizedBox(height: 30),
          Image.asset(
            image,
            height: 300,
            fit: BoxFit.contain,
          ),

          // L'indicateur est affiché ici, entre l'image et le texte
          if (indicator != null) ...[
            const SizedBox(height: 8
          ),
            indicator!,
            const SizedBox(height: 50), // Espacement après l'indicateur et avant le texte
          ],
          
          Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child:
                Column(
                  children: [
                    Text(title, style: KTypography.h1(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),textAlign:TextAlign.center,),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: KTypography.h5(context, color: Colors.black ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (action != null) action!,
        ],
      ),
    );
  }
}