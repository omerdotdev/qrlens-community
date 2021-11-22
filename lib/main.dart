import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/config/theme_config/AppTheme.dart';
import 'package:qrlens_community/config/theme_config/ThemeModel.dart';
import 'package:provider/provider.dart';

import 'widgets/qr_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Lens',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: QRHome(title: 'QR Lens'),
      ),
    );
  }
}
