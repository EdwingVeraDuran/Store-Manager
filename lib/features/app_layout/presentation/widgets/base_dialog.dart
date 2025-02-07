import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final double width;
  final double height;
  final Widget child;
  final void Function()? onPressed;
  const BaseDialog(
      {super.key,
      required this.title,
      required this.buttonText,
      required this.width,
      required this.height,
      required this.child,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevarmElevatedCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ElevarmFontSizes.xl,
                      fontWeight: ElevarmFontWeights.bold,
                    ),
                  ),
                  ElevarmTertiaryNeutralButton.iconOnly(
                    iconAssetName: HugeIcons.strokeRoundedCancel01,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Expanded(
                child: child,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevarmPrimaryButton.text(
                    text: buttonText,
                    onPressed: onPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
