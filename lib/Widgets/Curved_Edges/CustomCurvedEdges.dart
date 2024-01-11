import 'package:flutter/material.dart';
import 'Curved_Edges.dart';

class CustomCurveEdgesWidget extends StatelessWidget {
  const CustomCurveEdgesWidget({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: child,
    );
  }
}
