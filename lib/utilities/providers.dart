import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:realtime_communication_app/features/authentication/presentaion/providers/login_provider.dart';
import 'package:realtime_communication_app/utilities/keys.dart';

import '../features/authentication/presentaion/providers/user_provider.dart';
import '../services/theme/theme_manager.dart';

List<SingleChildWidget> providers(BuildContext context) {
  return [
    ChangeNotifierProvider<ThemeManager>(create: (context) => ThemeManager()),
    ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
    ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
    StreamProvider(
        create: (context) => context.read<LoginProvider>().authState,
        initialData: null)
  ];
}

var loginProvider =
    Provider.of<LoginProvider>(materialKey.currentContext!, listen: false);
var userProvider =
    Provider.of<UserProvider>(materialKey.currentContext!, listen: false);
