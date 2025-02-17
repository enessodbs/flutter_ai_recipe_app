import 'package:bloc/bloc.dart';
import 'package:flutter_recipe_app/services/auth/auth_service.dart';

class AuthCubit extends Cubit<void> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(null);

  // Giriş yapma
  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      print('Giriş yaparken hata: $e');
    }
  }

  // Kayıt olma
  Future<void> register(String email, String password, String username) async {
    try {
      await _authService.registerWithEmailAndPassword(email, password, username);
    } catch (e) {
      print('Kayıt olurken hata: $e');
    }
  }

  // Çıkış yapma
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      print('Çıkış yaparken hata: $e');
    }
  }

  // Kullanıcı adı al
  Future<String?> getUserName() async {
    try {
      return await _authService.getUserName();
    } catch (e) {
      print('Kullanıcı adı alınırken hata: $e');
      return null;
    }
  }
}
