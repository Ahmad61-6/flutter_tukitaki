import 'package:get/get.dart';
import 'package:task_1/core/service/image_picker_service.dart';
import 'package:task_1/features/auth/presentation/controller/form_controller.dart';
import 'package:task_1/features/home/presentation/controllers/home_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImagePickerService());
    Get.put(FormController());
    Get.put(HomeController());
  }
}
