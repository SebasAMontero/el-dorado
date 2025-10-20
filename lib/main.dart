import 'package:el_dorado/src/config/bootstrapper.dart';
import 'package:el_dorado/src/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/app_constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Bootstrapper.initBlocs(),
      child: MaterialApp(
        title: StringConstants.elDoradoName,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteConstants.coinsExchange,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
