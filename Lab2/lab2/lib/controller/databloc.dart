import 'storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define events
abstract class DataEvent {}

class FetchDataEvent extends DataEvent {
  final String key;

  FetchDataEvent(this.key);
}

class UpdateDataEvent extends DataEvent {
  final String key;
  final String value;

  UpdateDataEvent(this.key, this.value);
}

class SaveDataEvent extends DataEvent {
  final String key;
  final String value;

  SaveDataEvent(this.key, this.value);
}

// Define states
abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final String? data;

  DataLoaded(this.data);
}

class DataError extends DataState {
  final String message;

  DataError(this.message);
}

// Define DataBloc
class DataBloc extends Bloc<DataEvent, DataState> {
  final LocalStorage storage;

  DataBloc(this.storage) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchDataEvent) {
      yield DataLoading();
      try {
        final data = await storage.getData(event.key);
        yield DataLoaded(data);
      } catch (e) {
        yield DataError("Failed to fetch data: $e");
      }
    } else if (event is UpdateDataEvent) {
      yield DataLoading();
      try {
        await storage.updateData(event.key, event.value);
        final data = await storage.getData(event.key);
        yield DataLoaded(data);
      } catch (e) {
        yield DataError("Failed to update data: $e");
      }
    } else if (event is SaveDataEvent) {
      yield DataLoading();
      try {
        await storage.saveData(event.key, event.value);
        yield DataLoaded(event.value);
      } catch (e) {
        yield DataError("Failed to save data: $e");
      }
    }
  }
}
