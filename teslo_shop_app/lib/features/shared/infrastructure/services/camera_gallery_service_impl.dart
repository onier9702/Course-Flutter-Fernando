import 'package:image_picker/image_picker.dart';
import './camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {    
    
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // 80% of the quality
    );

    if (image == null) return null;

    print(image.path);
    return image.path;
  }

  @override
  Future<String?> takePhoto() async {
    
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80, // 80% of the quality
      preferredCameraDevice: CameraDevice.rear, // back camera
      // preferredCameraDevice: CameraDevice.front, // front camera
    );

    if (image == null) return null;

    return image.path;

  }

  @override
  Future<List<String>> selectMultiplePhotos() {
    throw UnimplementedError();
  }

}
