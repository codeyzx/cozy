import 'package:chyess/src/features/auth/domain/request_user.dart';
import 'package:chyess/src/features/auth/domain/user.dart';
import 'package:chyess/src/services/remote/remote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_repository.g.dart';

class CommonRepository {
  final userDb = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  final requestUserDb = FirebaseFirestore.instance
      .collection('users')
      .withConverter(
        fromFirestore: (snapshot, _) => RequestUser.fromJson(snapshot.data()!),
        toFirestore: (RequestUser user, _) => user.toJson(),
      );

  String? getUid() {
    return auth.FirebaseAuth.instance.currentUser?.uid;
  }

  Future<Result<User>> getProfile() async {
    String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      Logger().e('User not found');
      return Result.failure(
        const NetworkExceptions.notFound('User not found'),
        StackTrace.current,
      );
    }
    try {
      final resultUser = await userDb.doc(uid).get();
      final user = resultUser.data()!;
      return Result.success(user);
    } catch (e, st) {
      Logger().e(e);
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  // getDesigners
  Future<Result<List<User>>> getDesigners() async {
    try {
      final result = await userDb
          .where('role', isEqualTo: 'designer')
          .where('isSuccessRegister', isEqualTo: true)
          .get();
      final designers = result.docs.map((e) => e.data()).toList();
      return Result.success(designers);
    } catch (e, st) {
      Logger().e(e);
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  // getDesigner
  Future<Result<User>> getDesigner(String id) async {
    try {
      final result = await userDb.doc(id).get();
      final designer = result.data()!;
      return Result.success(designer);
    } catch (e, st) {
      Logger().e(e);
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  bool isLogin() {
    return auth.FirebaseAuth.instance.currentUser != null;
  }

  Future<Result<String>> updateProfile(RequestUser user) async {
    try {
      await requestUserDb.doc(user.id).update(user.toJson());
      return const Result.success('Success');
    } catch (e, st) {
      Logger().e(e);
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }
}

@Riverpod(keepAlive: true)
CommonRepository commonRepository(CommonRepositoryRef ref) {
  return CommonRepository();
}
