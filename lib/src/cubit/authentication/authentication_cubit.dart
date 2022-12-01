import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepro/src/cubit/authentication/authentication_repository.dart';
import 'package:firepro/src/helpers/storage_helper.dart';
import 'package:firepro/src/helpers/storage_key.dart';
import 'package:firepro/src/models/user_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  AuthenticationRepository _repository = AuthenticationRepository();

  Future<void> createUser(UserModel userModel) async {
    emit(AuthenticationLoading());
    try {
      UserCredential user = await _repository.createUser(
          userModel.email, userModel.password ?? "");
      String token = await user.user!.getIdToken();
      String uid = user.user!.uid;
      StorageHelper.writeData(StorageKey.token.name, token);
      StorageHelper.writeData(StorageKey.userId.name, uid);
      //TODO: store token, and id to the storage
      userModel.id = uid;
      await _repository.storeUserData(userModel);
      emit(AuthenticationSuccess());
    } catch (ex) {
      emit(AuthenticationError("error message"));
    }
  }

  loginUser(String email, String password) async {
    emit(AuthenticationLoading());
    try {
      UserCredential user = await _repository.loginUser(email, password);
      String token = await user.user!.getIdToken();
      String uid = user.user!.uid;
      StorageHelper.writeData(StorageKey.token.name, token);
      StorageHelper.writeData(StorageKey.userId.name, uid);
      //TODO: store token, and id to the storage
      emit(AuthenticationSuccess());
    } catch (ex) {
      emit(AuthenticationError("error message"));
    }
  }

  logoutUser() async {
    await _repository.logoutUser();
  }
}
