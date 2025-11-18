import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/auth_manage/registration_page.dart';
import 'package:noworry_app/components/ui/model.dart';

import '../components/ui/button.dart';
import '../theme/styles.dart';


// Fin des placeholders

class WelcomePage extends StatefulWidget {
  const WelcomePage ({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController controller = PageController();
  int selected = 0; // L'index de la page actuellement sélectionnée (État)

  // --- Widget des indicateurs de page (les points) ---
  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // Nombre total de pages
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: selected == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: selected == index ? AppColors.orange : AppColors.grayL,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    
    final AppLocalizations l = AppLocalizations.of(context)!;

    // Bouton "Get Started" (défini une seule fois)
    final Widget getStartedButton = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Button(
          onPressed: () {
    Navigator.pushReplacement( 
        context,
        MaterialPageRoute(
            builder: (context) => const RegistrationPage(),
        ),
    );
},
          backgroundColor: AppColors.tertiary,
          borderColor: AppColors.tertiary,
          foregroundColor: Colors.black,
          child: Text(
            "Get Started",
            style: KTypography.h4(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      );
    
    // Le widget indicateur construit ici
    final Widget pageIndicatorWidget = _buildPageIndicators();

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller,
        onPageChanged: (value) => setState(() => selected = value),
        children: [

          // Page 1 (Index 0): 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Model(
              title: l.pageTitle1,
              image: "assets/images/img1.png",
              description:l.desc1,
              indicator: pageIndicatorWidget,
             
            ),
          ),
          
          // Page 2 (Index 1): 
         Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 20.0),
           child: Model(
              title:l.pageTitle2,
              image: "assets/images/img2.png",
              description: l.desc2,
              indicator: pageIndicatorWidget,
              
            ),
         ),
         
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Model(
              title:l.pageTitle3,
              image: "assets/images/img3.png",
              description: l.desc3,
              indicator: pageIndicatorWidget,
             
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        child: getStartedButton,),
    );
  }
}