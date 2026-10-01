import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Simpan Session
  //  static digunakan agar kita bisa mengakses sebuah method secara langsung dari luar
  static Future<void> login(String username) async {
    // membuat objek shared preferences
    final prefs = await SharedPreferences.getInstance();
    // mengatur user sudah login
    await prefs.setBool('isBool', true);
    // dipakai nanti untuk menentukan login ( isLogin ? home : login)
    await prefs.setString('username', username);
    // await prefs.setString('password', pass);
    // await prefs.setString('alamat', address);
    // await prefs.setString('nohp', hp);
  }

  // Cek sudah login atau belum
  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();

    // cek apakah user sudah login atau belum
    return prefs.getBool('isLogin') ?? false;
  }

  // Ambil Username
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // hapus data session
    await prefs.remove('isLogin');
    await prefs.remove('username');
  }
}