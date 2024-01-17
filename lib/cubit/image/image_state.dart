part of 'image_cubit.dart';

class ImageState extends Equatable {
  final String? imageUrl;
  final String? imagePath;
  final List<String> imageFile;
  const ImageState({
    this.imageUrl,
    this.imagePath,
    this.imageFile = const [],
  });

  @override
  List<Object?> get props => [imageUrl, imagePath, imageFile];

  ImageState copyWith({
    String? imageUrl,
    String? imagePath,
    List<String>? imageFile,
  }) {
    return ImageState(
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
