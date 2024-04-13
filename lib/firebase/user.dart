import 'package:meta/meta.dart';
import 'package:thc/firebase/firebase.dart';
import 'package:thc/utils/app_config.dart';
import 'package:thc/utils/local_storage.dart';

enum UserType {
  participant,
  director,
  admin;

  factory UserType.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    return values.firstWhere((userType) => userType.toString() == type);
  }

  String get testId => 'test_$name';
  static const _testName = 'First Lastname';

  ThcUser get testUser => switch (this) {
        participant => Participant(id: testId, name: _testName),
        director => Director(id: testId, name: _testName),
        admin => Admin(id: testId, name: _testName),
      };

  @override
  String toString() => switch (this) {
        participant => 'Participant',
        director => 'Director',
        admin => 'Admin',
      };
}

extension UserAuthorization on UserType? {
  bool get canLivestream => switch (this) {
        UserType.participant || null => false,
        UserType.director || UserType.admin => true,
      };

  bool get isAdmin => this == UserType.admin;
}

ThcUser? user;

UserType? get userType => user?.type;

String? get userId => StorageKeys.userId();

/// {@template ThcUser}
/// We can't just call this class `User`, since that's one of the Firebase classes.
/// {@endtemplate}
///
/// {@macro sealed_class}
@immutable
sealed class ThcUser {
  /// {@macro ThcUser}
  const ThcUser._({
    required this.name,
    required this.type,
    this.id,
    this.email,
    this.phone,
  }) : assert((id ?? email ?? phone) != null);

  /// {@macro ThcUser}
  factory ThcUser({
    required String name,
    required UserType type,
    String? id,
    String? email,
    String? phone,
  }) {
    return switch (type) {
      UserType.participant => Participant(
          name: name,
          id: id,
          email: email,
          phone: phone,
        ),
      UserType.director => Director(
          name: name,
          id: id,
          email: email,
          phone: phone,
        ),
      UserType.admin => Admin(
          name: name,
          id: id,
          email: email,
          phone: phone,
        ),
    };
  }

  /// {@macro ThcUser}
  factory ThcUser.fromJson(Map<String, dynamic> json) {
    return ThcUser(
      name: json['name'],
      type: UserType.fromJson(json),
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  final String name;
  final UserType type;

  /// A unique string to identify the user, probably chosen by an admin.
  final String? id;

  /// Used for password recovery.
  final String? email, phone;

  /// {@macro ThcUser}
  static Future<ThcUser> download(String id, {bool registered = true}) async {
    if (!useInternet) {
      return UserType.values.firstWhere((value) => id.contains(value.name)).testUser;
    }

    final collection = registered ? 'users' : 'unregistered_users';
    final snapshot = await db.doc('$collection/$id').get();
    return ThcUser.fromJson(snapshot.data()!);
  }

  /// {@macro ThcUser}
  ThcUser copyWith({
    UserType? type,
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return ThcUser(
      type: type ?? this.type,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> get json => {
        'name': name,
        'type': '$type',
        if (id != null) 'id': id,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      };

  /// Saves the current user data to Firebase.
  Future<void> upload({bool isRegistered = true}) async {
    final collection = isRegistered ? 'users' : 'unregistered_users';
    await db.doc('$collection/$id').set(json);
  }

  Future<void> removeUnregisteredUser(String id) async =>
      await db.doc('unregistered_users/$id').delete();

  @override
  bool operator ==(Object other) {
    return other is ThcUser &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, phone);
}

class Participant extends ThcUser {
  const Participant({
    required super.id,
    required super.name,
    super.email,
    super.phone,
  }) : super._(type: UserType.participant);
}

class Director extends ThcUser {
  const Director({
    required super.id,
    required super.name,
    super.email,
    super.phone,
  }) : super._(type: UserType.director);
}

class Admin extends ThcUser {
  const Admin({
    required super.id,
    required super.name,
    super.email,
    super.phone,
  }) : super._(type: UserType.admin);
}
