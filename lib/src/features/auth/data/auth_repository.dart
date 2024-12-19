import 'package:chyess/src/features/auth/domain/request_login.dart';
import 'package:chyess/src/features/auth/domain/request_register.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/services/remote/remote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final auth.FirebaseAuth _auth;

  final userDb = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  Future<Result> login(RequestLogin requestLogin) async {
    try {
      final emailAddress = requestLogin.email;
      final password = requestLogin.password;
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      final user = credential.user;
      if (user == null) {
        Logger().e('User not found');
        return Result.failure(
            NetworkExceptions.getFirebaseException('User not found'),
            StackTrace.current);
      }

      return const Result.success(true);
    } catch (e, stackTrace) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), stackTrace);
    }
  }

  Future<Result> register(RequestRegister requestRegister) async {
    try {
      final emailAddress = requestRegister.email;
      final password = requestRegister.password;

      final credential = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      final credUser = credential.user;
      // Map<String, dynamic> user = {
      //   'id': credUser!.uid,
      //   'name': requestRegister.name,
      //   'email': requestRegister.email,
      //   'photoUrl': '',
      //   'fetalId': '',
      //   'isSuccessRegister': false,
      //   'fetalDate': null,
      // };
      User user = User(
        id: credUser!.uid,
        name: requestRegister.name,
        email: requestRegister.email,
        role: requestRegister.role,
        isSuccessRegister: requestRegister.role == 'user',
        status: '',
      );

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(credUser.uid)
      //     .set(user.toJson());

      await userDb.doc(credUser.uid).set(user);

      return const Result.success(true);
    } catch (e, stackTrace) {
      Logger().e(e);
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), stackTrace);
    }
  }

  Future<Result> updateProfile(User user) async {
    try {
      await userDb.doc(user.id).update(user.toJson());
      return const Result.success(true);
    } catch (e, st) {
      Logger().e(e);
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<void> updateStatusRegister(
      String id, Map<String, dynamic> data) async {
    try {
      await userDb.doc(id).update(data);
    } catch (e, _) {
      Logger().e(NetworkExceptions.getFirebaseException(e));
    }
  }

  Future<Result> logout() async {
    try {
      await _auth.signOut();
      return const Result.success(true);
    } catch (e, st) {
      Logger().e(e);
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(auth.FirebaseAuth.instance);
}
