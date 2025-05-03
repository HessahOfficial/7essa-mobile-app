import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/presentation/managers/settings_cubit.dart';

class ThemeSwitch extends StatefulWidget {
  final String title;

  const ThemeSwitch({super.key, required this.title});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late bool _toggled;

  @override
  void initState() {
    _toggled = getIt.get<HiveHelper>().isDark ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Switch(
            inactiveTrackColor: Theme.of(context).scaffoldBackgroundColor,
            activeColor: Theme.of(context).colorScheme.primary,
            value: _toggled,
            onChanged:
                (value) => setState(() {
                  _toggled = value;
                  context.read<SettingsCubit>().changeTheme(isDark: value);
                }),
          ),
        ],
      ),
    );
  }
}
