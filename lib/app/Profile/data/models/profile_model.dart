import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.user,
    super.carsList,
  });

  // factory ProfileModel.fromJson(Map<String, dynamic> json) {
  //   try {
  //     if (!json.containsKey('user')) {
  //       throw DataError.missingParameters();
  //     }
  //     final user = User()
  //       ..id = json['user']['id']
  //       ..firstName = json['user']['firstName']
  //       ..lastName = json['user']['lastName']
  //       ..email = json['user']['email']
  //       ..username = json['user']['userName']
  //       ..driverLicense = ''
  //       ..phoneNumber = '';

  //     return ProfileModel(
  //       user: user,
  //       carsList: [],
  //     );
  //   } on DataError catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     throw DataError.failedToConvert();
  //   }
  // }


}
