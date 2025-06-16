import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/settings/presentation/managers/settings_cubit.dart';

class LocaleSwitch extends StatefulWidget {
  final String title;

  const LocaleSwitch({super.key, required this.title});

  @override
  State<LocaleSwitch> createState() => _LocaleSwitchState();
}

class _LocaleSwitchState extends State<LocaleSwitch> {
  late bool _toggled;

  @override
  void initState() {
    _toggled = getIt.get<HiveHelper>().locale != "en";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.translate_rounded),
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Spacer(),
          Switch(
            inactiveTrackColor: Theme.of(context).scaffoldBackgroundColor,
            activeColor: Theme.of(context).colorScheme.primary,
            value: _toggled,
            onChanged:
                (value) => setState(() {
                  _toggled = value;
                  context.read<SettingsCubit>().changeLocale(isArabic: value);
                }),
          ),
        ],
      ),
    );
  }
}
