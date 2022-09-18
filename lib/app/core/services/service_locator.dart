import 'package:carpooling_beta/app/Auth/data/datasource/auth_local_datasource.dart';
import 'package:carpooling_beta/app/Auth/data/datasource/auth_remote_datasource.dart';
import 'package:carpooling_beta/app/Auth/data/repository/auth_repository.dart';
import 'package:carpooling_beta/app/Auth/domain/repository/base_auth_repository.dart';
import 'package:carpooling_beta/app/Auth/domain/usecases/login_usecase.dart';
import 'package:carpooling_beta/app/Auth/domain/usecases/register_usecase.dart';
import 'package:carpooling_beta/app/Chat/data/datasource/Chat_remote_datasource.dart';
import 'package:carpooling_beta/app/Chat/data/repository/chat_repository.dart';
import 'package:carpooling_beta/app/Chat/domain/repository/base_chat_repository.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_messages_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/send_message_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_conversations_usecase.dart';
import 'package:carpooling_beta/app/Home/data/datasource/ride_remote_datasource.dart';
import 'package:carpooling_beta/app/Home/domain/repository/base_ride_repository.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/add_checkings_usecase.dart';
import 'package:carpooling_beta/app/Profile/data/datasource/car_remote_datasource.dart';
import 'package:carpooling_beta/app/Profile/data/datasource/profile_local_datasource.dart';
import 'package:carpooling_beta/app/Profile/data/datasource/profile_remote_datasource.dart';
import 'package:carpooling_beta/app/Profile/data/repository/profile_repository.dart';
import 'package:carpooling_beta/app/Profile/domain/repository/base_car_repository.dart';
import 'package:carpooling_beta/app/Profile/data/repository/car_repository.dart';
import 'package:carpooling_beta/app/Profile/domain/repository/base_profile_repository.dart';
import 'package:carpooling_beta/app/Profile/domain/usecases/profile_usecase.dart';
import 'package:carpooling_beta/app/Profile/domain/usecases/update_profile_usecase.dart';
import 'package:carpooling_beta/app/Profile/domain/usecases/car_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/rides_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/add_ride_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/find_ride_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/checkings_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/cancel_checking_usecase.dart';
import 'package:carpooling_beta/app/Home/data/repository/ride_repository.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class ServiceLoctor {
  void init() {
    /// DATASOURCES
    // Local DataSource
    serviceLocator.registerLazySingleton<BaseLocalDatabaseOperations>(
        () => UserLocalDataBaseOperations());
    // Auth DataSource
    serviceLocator.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
    serviceLocator.registerLazySingleton<BaseAuthLocalDataSource>(
        () => AuthLocalDataSource(serviceLocator()));
    // Profile DataSource
    serviceLocator.registerLazySingleton<BaseProfileRemoteDataSource>(
        () => ProfileRemoteDataSource());
    serviceLocator.registerLazySingleton<BaseProfileLocalDataSource>(
        () => ProfileLocalDataSource(serviceLocator()));
    // Car DataSource
    serviceLocator.registerLazySingleton<BaseCarRemoteDataSource>(
        () => CarRemoteDataSource());
    // Ride DataSource
    serviceLocator.registerLazySingleton<BaseRideRemoteDataSource>(
        () => RideRemoteDataSource());
    // Chat DataSource
    serviceLocator.registerLazySingleton<BaseChatRemoteDataSource>(
        () => ChatRemoteDataSource());

    /// REPOSIORIES
    // Auth Repositories
    serviceLocator.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepository(serviceLocator(), serviceLocator()));
    // Profile Repositories
    serviceLocator.registerLazySingleton<BaseProfileRepository>(
        () => ProfileRepository(serviceLocator(), serviceLocator()));
    // Car Repositories
    serviceLocator.registerLazySingleton<BaseCarRepository>(
        () => CarRepository(serviceLocator()));
    // Ride Repositories
    serviceLocator.registerLazySingleton<BaseRideRepository>(
        () => RideRepository(serviceLocator()));
    // Chat Repositories
    serviceLocator.registerLazySingleton<BaseChatRepository>(
        () => ChatRepository(serviceLocator()));

    //// USECASES
    // Auth Usecases
    serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => RegisterUseCase(serviceLocator()));
    // Profile Usecases
    serviceLocator
        .registerLazySingleton(() => ProfileUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => UpdateProfileUseCase(serviceLocator()));

    // Car Usecases
    serviceLocator.registerLazySingleton(() => CarUseCase(serviceLocator()));
    // Ride Usecases
    serviceLocator
        .registerLazySingleton(() => GetRidesUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => AddRideUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => FindRideUseCase(serviceLocator()));
    // Checking Usecases
    serviceLocator
        .registerLazySingleton(() => CheckingsUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => AddCheckingUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => CancelChechingUseCase(serviceLocator()));
    // Chat Usecases
    serviceLocator
        .registerLazySingleton(() => GetMessagesUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => SendMessageUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetConversationsUseCase(serviceLocator()));
  }
}
