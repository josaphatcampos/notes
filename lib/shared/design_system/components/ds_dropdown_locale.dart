import 'package:cocus/shared/design_system/theme/ds_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/locale_provider.dart';

class DSDropdownLocale extends StatelessWidget {
  const DSDropdownLocale({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final color = Theme.of(context).colorScheme;

    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: localeProvider.locale,
        icon: Icon(Icons.language, color: DSColors.white),
        dropdownColor: color.primary,
        items: const [
          DropdownMenuItem(value: Locale('pt'), child: Text('🇵🇹 Português')),
          DropdownMenuItem(value: Locale('en'), child: Text('🇺🇸 English')),
        ],
        onChanged: (locale) {
          if (locale != null) localeProvider.setLocale(locale);
        },
      ),
    );
  }
}
