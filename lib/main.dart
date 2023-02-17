import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'injection.dart' as di;
import 'observer.dart';

Future<void> main() async {
  Bloc.observer = AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TodoApp());
}
