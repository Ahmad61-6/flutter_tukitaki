import 'package:firebase_code/services/shared_preference_service.dart';
import 'package:get/instance_manager.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SharedPreferenceService());
  }
}
