import 'package:flutter/material.dart';
import 'package:mysample/services/session_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk mengambil isi username
  final usernameController = TextEditingController();

  // Controller untuk mengambil isi password
  final passwordController = TextEditingController();

  // Untuk menampilkan / menyembunyikan password
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =========================
                // JUDUL
                // =========================

                const Text(
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Login untuk melanjutkan',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 35),

                // =========================
                // USERNAME
                // =========================

                const Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan username',

                    prefixIcon: const Icon(
                      Icons.person_outline,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =========================
                // PASSWORD
                // =========================

                const Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: passwordController,

                  // false = password disembunyikan
                  // true = password ditampilkan
                  obscureText: !passwordVisible,

                  decoration: InputDecoration(
                    hintText: 'Masukkan password',

                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),

                    // Tombol untuk melihat password
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },

                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // TOMBOL LOGIN
                // =========================

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed: () async {

                      // Mengambil username dari TextField
                      String username =
                          usernameController.text.trim();

                      // Mengambil password dari TextField
                      String password =
                          passwordController.text.trim();

                      // =========================
                      // CEK INPUT KOSONG
                      // =========================

                      if (username.isEmpty ||
                          password.isEmpty) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Username dan password wajib diisi!',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );

                        return;
                      }

                      // =========================
                      // CEK LOGIN
                      // =========================

                      if (username == 'admin' &&
                          password == '12345') {
                            // simpan session login
                            await SessionService.login(username);

                            // pengaman, cek apakah halaman ini masih ada
                            if (!mounted) return;

                        // =========================
                        // DATA DIRI
                        // =========================

                        Map<String, dynamic> dataDiri = {

                          // Nama user
                          'name': 'Arya',

                          // Username yang digunakan login
                          'username': username,

                          // Umur
                          'age': 30,

                          // Role user
                          'role': 'admin',

                          // Status sesi login
                          'session': true,

                          // Waktu login
                          'loginTime': DateTime.now(),
                        };

                        // =========================
                        // PINDAH KE HOME
                        // =========================

                        Navigator.pushReplacementNamed(
                          context,
                          '/home',

                          // Mengirim data ke NavigationExample
                          arguments: {
                            'data': dataDiri,
                          },
                        );

                      } else {

                        // =========================
                        // LOGIN GAGAL
                        // =========================

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Username atau password salah!',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // REGISTER
                // =========================

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      'Belum punya akun? ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    TextButton(
                      onPressed: () {

                        // Pindah ke halaman Register
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RegisterScreen(),
                          ),
                        );
                      },

                      child: const Text('Daftar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}