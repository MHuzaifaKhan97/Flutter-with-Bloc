part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoCreateDatabaseState extends TodoState {}

class TodoInsertingIntoDatabaseState extends TodoState {}

class TodoGettingDataFromDatabaseState extends TodoState {}

class TodoUpdateDataFromDatabaseState extends TodoState {}

class TodoLoadingDataFromDatabaseState extends TodoState {}

class TodoDeletingDataFromDatabaseState extends TodoState {}

class TodoChangeLangToEnglishState extends TodoState {}

class TodoChangeLangToArabicState extends TodoState {}
