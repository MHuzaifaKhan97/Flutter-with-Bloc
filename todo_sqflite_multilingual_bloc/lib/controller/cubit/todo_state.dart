part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoCreateDatabaseState extends TodoState {}

class TodoInsertingIntoDatabaseState extends TodoState {}

class TodoGettingDataFromDatabaseState extends TodoState {}

class TodoDeletingDataFromDatabaseState extends TodoState {}
