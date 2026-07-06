import 'package:shared_preferences/shared_preferences.dart';

class KamcaUserSession {
  const KamcaUserSession({
    required this.userName,
    this.profileImageAsset,
  });

  final String userName;
  final String? profileImageAsset;
}

class KamcaSessionStore {
  KamcaSessionStore._();

  static final KamcaSessionStore instance = KamcaSessionStore._();

  static const String _userNameKey = 'kamca.session.userName';
  static const String _profileImageAssetKey = 'kamca.session.profileImageAsset';

  SharedPreferences? _preferences;
  KamcaUserSession? _currentUser;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _currentUser = _readStoredUser(_preferences!);
  }

  bool get isLoggedIn => _currentUser != null;

  String get userName => _currentUser?.userName ?? 'User';

  String? get profileImageAsset => _currentUser?.profileImageAsset;

  KamcaUserSession? get currentUser => _currentUser;

  Future<void> saveUser({
    required String userName,
    String? profileImageAsset,
  }) async {
    final SharedPreferences preferences = await _ensurePreferences();
    final String trimmedUserName = userName.trim();

    await preferences.setString(_userNameKey, trimmedUserName);

    if (profileImageAsset == null || profileImageAsset.isEmpty) {
      await preferences.remove(_profileImageAssetKey);
    } else {
      await preferences.setString(_profileImageAssetKey, profileImageAsset);
    }

    _currentUser = KamcaUserSession(
      userName: trimmedUserName,
      profileImageAsset: profileImageAsset == null || profileImageAsset.isEmpty ? null : profileImageAsset,
    );
  }

  Future<void> clearUser() async {
    final SharedPreferences preferences = await _ensurePreferences();
    await preferences.remove(_userNameKey);
    await preferences.remove(_profileImageAssetKey);
    _currentUser = null;
  }

  KamcaUserSession? _readStoredUser(SharedPreferences preferences) {
    final String? storedUserName = preferences.getString(_userNameKey);
    if (storedUserName == null || storedUserName.trim().isEmpty) {
      return null;
    }

    final String? storedProfileImageAsset = preferences.getString(_profileImageAssetKey);

    return KamcaUserSession(
      userName: storedUserName.trim(),
      profileImageAsset: storedProfileImageAsset == null || storedProfileImageAsset.isEmpty
          ? null
          : storedProfileImageAsset,
    );
  }

  Future<SharedPreferences> _ensurePreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }
}