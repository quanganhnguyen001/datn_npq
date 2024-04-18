part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({this.imageBytes});
  final Uint8List? imageBytes;

  UpdateProfileState copyWith(Uint8List? imageBytes) {
    return UpdateProfileState(imageBytes: imageBytes ?? this.imageBytes);
  }

  @override
  List<Object?> get props => [imageBytes];
}
