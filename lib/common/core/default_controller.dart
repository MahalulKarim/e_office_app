import 'package:get/get.dart';

enum AppState {
  loading,
  loaded,
  error,
}

class DefaultController extends GetxController {
  final _state = AppState.loading.obs;
  get state => _state.value;
  set state(value) => _state.value = value;
}
