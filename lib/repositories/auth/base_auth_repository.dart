abstract class BaseAuthRepository {
  Future<void> signUp({required String email, required String password});
}
