// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Responseivelayout extends StatefulWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  const Responseivelayout({
    Key? key,
    required this.mobileBody,
    required this.tabletBody,
  }) : super(key: key);

  @override
  State<Responseivelayout> createState() => _ResponseivelayoutState();
}

class _ResponseivelayoutState extends State<Responseivelayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        // Mobile layout
        return widget.mobileBody;
      } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1200) {
        // Tablet layout
        return widget.tabletBody;
      }else{
        return SizedBox();
      }
    });
  }
}
