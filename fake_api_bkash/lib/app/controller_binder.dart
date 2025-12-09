import 'package:fake_api_bkash/app/controller/auth_controller.dart';
import 'package:get/instance_manager.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
   Get.put(AuthController());
  }

}