import 'package:flutter/material.dart';

import '../../theme/styles.dart';

class Layout extends StatelessWidget {

  final String title;
  final String subtitle;
  final Widget child;

  const Layout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [

      Expanded(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "$title",
                  style:KTypography.h3(context,color: Colors.black,),
                ),
                
                Text(
                  "$subtitle",
                  style: KTypography.h4(context,color:Colors.black),
                ),
               
                child,
              ],
            ),
          ],
        ),
      ),
    ];

    return Row(
      children: widgets,
    );
  }
}
