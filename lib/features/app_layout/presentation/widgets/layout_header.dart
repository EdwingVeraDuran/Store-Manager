import 'dart:async';

import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class LayoutHeader extends StatefulWidget {
  final TextEditingController controller;
  final Function(String p1) onSearch;
  final VoidCallback onClearSearch;
  final void Function() onCreate;

  const LayoutHeader({
    super.key,
    required this.onSearch,
    required this.onClearSearch,
    required this.onCreate,
    required this.controller,
  });

  @override
  State<LayoutHeader> createState() => _LayoutHeaderState();
}

class _LayoutHeaderState extends State<LayoutHeader> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 750),
      () {
        widget.onSearch(query);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 300,
          child: ElevarmTextInputField(
            prefixIconAssetName: HugeIcons.strokeRoundedSearch01,
            suffixIconAssetName: HugeIcons.strokeRoundedCancelCircle,
            controller: widget.controller,
            onChanged: _onSearchChanged,
            onTapSuffix: widget.onClearSearch,
          ),
        ),
        ElevarmPrimaryButton.text(
          text: "Crear",
          onPressed: widget.onCreate,
        ),
      ],
    );
  }
}
