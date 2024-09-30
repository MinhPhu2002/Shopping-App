abstract class OtpVertificationRepo {
  Future<bool> vertifyOtp({required String username, required String otp});
}
