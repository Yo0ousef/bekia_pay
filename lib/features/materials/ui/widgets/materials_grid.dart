import 'package:bekia_pay/features/materials/data/models/material_model.dart';
import 'package:bekia_pay/features/materials/ui/widgets/material_item.dart';
import 'package:flutter/material.dart';

class MaterialsGrid extends StatelessWidget {
  final List<MaterialModel> materials;

  const MaterialsGrid({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: materials.length,
      padding: const .symmetric(horizontal: 10, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final material = materials[index];
        return MaterialItem(material: material);
      },
    );
  }
}
