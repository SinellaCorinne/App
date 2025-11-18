import 'package:flutter/material.dart';
import 'package:noworry_app/grossistes/pages/dashboard/dashboard_page.dart';
import 'package:noworry_app/clients/pages/home/home.dart';
import 'package:noworry_app/theme/styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l.onafaliTitle,
          style: KTypography.h1(context, color: AppColors.primary)
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l.selectRoleInstruction, // traduction
              style: KTypography.h4(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isSmallScreen = constraints.maxWidth < 600;

                return isSmallScreen
                    ? Column(
                        children: [
                          _buildRoleContainer(
                            context,
                            roleName: l.roleClient,
                            icon: Icons.shopping_bag_outlined,
                            description: l.roleClientDesc,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Home()),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildRoleContainer(
                            context,
                            roleName: l.roleVendor,
                            icon: Icons.storefront_outlined,
                            description: l.roleVendorDesc,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const DashboardPage()),
                              );
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildRoleContainer(
                              context,
                              roleName: l.roleClient,
                              icon: Icons.shopping_bag_outlined,
                              description: l.roleClientDesc,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>  Home()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildRoleContainer(
                              context,
                              roleName: l.roleVendor,
                              icon: Icons.storefront_outlined,
                              description: l.roleVendorDesc,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const DashboardPage()),
                                );
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleContainer(
    BuildContext context, {
      
    required String roleName,
    required IconData icon,
    required String description,
    required VoidCallback onPressed,
  }) {
    final l = AppLocalizations.of(context)!;

    return Container(

      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayL, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(height: 15),
          Text(
            roleName,
            style: KTypography.h4(context, color: AppColors.primary)
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: KTypography.h7(context, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                l.continueButton,
                style: KTypography.h7(context, color: Colors.white)
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
