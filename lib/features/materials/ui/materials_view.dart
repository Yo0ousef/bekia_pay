import 'package:bekia_pay/core/shared/widgets/reload.dart';
import 'package:bekia_pay/core/utils/constants/app_constants.dart';
import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:bekia_pay/features/materials/logic/materials_cubit.dart';
import 'package:bekia_pay/features/materials/ui/widgets/materials_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialsView extends StatelessWidget {
  const MaterialsView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Materials"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: BlocBuilder<MaterialsCubit, MaterialsState>(
        builder: (context, state) {
          return state.when(
            loading: () => AppConstants.loading.center,
            success: (materials) => MaterialsGrid(materials: materials),
            failure: (message) {
              return Reload(
                onTap: () {
                  context.read<MaterialsCubit>().getMaterials();
                },
              );
            },
          );
        },
      ),
    );
  }
}
