import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_cubit.dart';

class UserLogout extends StatelessWidget {
  const UserLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Column(
      children: [
        Divider(thickness: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ElevarmAvatar(
                    emptyIconAssetName: HugeIcons.strokeRoundedUser,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      authCubit.currentUser!.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: ElevarmFontSizes.md,
                        fontWeight: ElevarmFontWeights.semibold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevarmTertiaryNeutralButton.iconOnly(
              iconAssetName: HugeIcons.strokeRoundedLogout01,
              onPressed: () {
                authCubit.logout();
              },
            ),
          ],
        ),
      ],
    );
  }
}
