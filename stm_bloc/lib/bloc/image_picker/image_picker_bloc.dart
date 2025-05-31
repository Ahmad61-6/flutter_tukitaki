import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stm_bloc/utils/image_picker_utils.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc({required this.imagePickerUtils})
    : super(ImagePickerState()) {
    on<CameraCapture>(_cameraCapture);
  }

  void _cameraCapture(
    CameraCapture event,
    Emitter<ImagePickerState> states,
  ) async {
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }
}
