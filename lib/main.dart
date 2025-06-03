import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ineventory/bloc.dart';
import 'package:simple_ineventory/core/router/app_router.dart';
import 'package:simple_ineventory/core/themes/app_theme.dart';
import 'package:simple_ineventory/init_dependencies.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        ...bloc,
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Simple Inventory',
      theme: AppTheme.lightThemeMode,
      routerConfig: AppRouter.routes,
    );
  }
}
