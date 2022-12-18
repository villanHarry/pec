import '../Constants/Imports.dart';

class ImageUpload {
  static Future<File> getImage(ImageSource value) async {
    late String filepath = "";
    final picker = ImagePicker();
    File? file;
    final pickedFile = await picker.getImage(source: value);
    if (pickedFile != null) {
      filepath = pickedFile.path;
    } else {
      filepath = "";
    }
    file = File(filepath);
    return file;
  }

  static Future<String> generate(BuildContext context, File file) async {
    final cloudinary = CloudinaryPublic(
      'ddmgkryey',
      'lfxclhrl',
    );

    late String url = "";

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file.path,
            resourceType: CloudinaryResourceType.Image, folder: "uploads"),
      );

      url = response.secureUrl;
      return url;
    } on CloudinaryException catch (e) {
      Screen.showSnackBar(context: context, content: e.message!);
      return url;
    }
  }
}
