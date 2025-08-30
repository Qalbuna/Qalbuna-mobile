import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Use the Android client ID for Android apps
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '990120265277-jdg3s6s1mrml7h9u6701a8kik8o5ri6h.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  Future<AuthResponse> signUpWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      return await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'username': username},
      );
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out from Google if signed in
      await _googleSignIn.signOut();
      // Sign out from Supabase
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  String? getCurrentUserEmail() {
    final user = _supabase.auth.currentUser;
    return user?.email;
  }

  String? getCurrentUserDisplayName() {
    final user = _supabase.auth.currentUser;
    return user?.userMetadata?['display_name'] ??
        user?.userMetadata?['full_name'] ??
        user?.userMetadata?['name'];
  }

  String? getCurrentUserAvatarUrl() {
    final user = _supabase.auth.currentUser;
    return user?.userMetadata?['avatar_url'] ?? user?.userMetadata?['picture'];
  }

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  bool isSignedIn() {
    return _supabase.auth.currentUser != null;
  }

  Stream<AuthState> get authStateChanges {
    return _supabase.auth.onAuthStateChange;
  }

  Future<AuthResponse> signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign in was cancelled by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception('No Access Token found');
      }
      if (idToken == null) {
        throw Exception('No ID Token found');
      }

      // Sign in to Supabase with Google tokens
      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  // Alias for sign up with Google (same implementation)
  Future<AuthResponse> signUpWithGoogle() async {
    return await signInWithGoogle();
  }
}
