import 'package:get_it/get_it.dart';

import 'data/storage/hive_db.dart';
import 'data/storage/storage.dart';
import 'modules/todos/bloc/todos_bloc.dart';
import 'repositories/todo_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Bloc
  sl.registerFactory(() => TodosBloc(sl()));
  // sl.registerFactory(() => DrugBloc(sl()));

  //! Use cases
  // sl.registerLazySingleton(() => GetDrugsByName(sl()));
  // sl.registerLazySingleton(() => GetDrugGenericInfo(sl()));

  //! Repositories
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  //! Data sources
  final hive = await HiveDb().init();
  sl.registerLazySingleton<LocalStorage>(() => hive);

  //! Core
  // sl.registerLazySingleton(() => InputConverter());

  //! Services

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
}
