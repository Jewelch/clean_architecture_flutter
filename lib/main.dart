import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jch_requester/generic_requester.dart';

import 'app/app_widget.dart';
import 'app/environment/app_environments.dart';
import 'core/managers/connectivity_manager.dart';

part 'main_binding.dart';
part 'main_config.dart';
part 'main_styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _Binding.all();

  _Styling.all();

  await _configureRequester();

  runApp(const AppWidget());
}
