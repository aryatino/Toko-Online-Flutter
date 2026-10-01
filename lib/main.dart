import 'package:flutter/material.dart';
import 'package:mysample/widgets/product_grid.dart';

import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
import 'pages/feeds_screen.dart';
import 'pages/home_screen.dart';
import 'pages/mall_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/transaction_screen.dart';

void main() {
  runApp(const NavigationBarApp());
}


// ==================================================
// MATERIAL APP
// ==================================================

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Aplikasi pertama kali membuka Login
      initialRoute: '/login',

      // Daftar route
      routes: {
        '/login': (context) => const LoginScreen(),

        '/register': (context) => const RegisterScreen(),

        // Setelah login berhasil
        // masuk ke NavigationExample
        '/home': (context) => const NavigationExample(),
      },
    );
  }
}


// ==================================================
// NAVIGATION EXAMPLE
// ==================================================

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() =>
      _NavigationExampleState();
}


// ==================================================
// STATE NAVIGATION
// ==================================================

class _NavigationExampleState
    extends State<NavigationExample> {

  // Menentukan halaman yang aktif
  int currentPageIndex = 0;

  // Menyimpan data yang dikirim dari LoginScreen
  Map<String, dynamic>? dataDiri;

  // Untuk memastikan dialog hanya muncul satu kali
  bool _dialogSudahMuncul = false;


  // ==================================================
  // MENGAMBIL ARGUMENTS
  // ==================================================

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Mengambil arguments dari LoginScreen
    final arguments =
        ModalRoute.of(context)?.settings.arguments;

    // Mengecek apakah arguments berupa Map
    if (arguments is Map<String, dynamic>) {

      // Mengambil data dengan key 'data'
      dataDiri = arguments['data'];

      // Cek apakah dialog sudah pernah muncul
      if (!_dialogSudahMuncul) {

        // Tandai bahwa dialog sudah akan ditampilkan
        _dialogSudahMuncul = true;

        // Menunggu sampai UI selesai dibuat
        WidgetsBinding.instance.addPostFrameCallback((_) {

          // Tampilkan dialog
          _showWelcomeDialog();
        });
      }
    }
  }


  // ==================================================
  // WELCOME DIALOG
  // ==================================================

  void _showWelcomeDialog() {

    // Mengambil nama dari dataDiri
    final String nama =
        dataDiri?['name'] ?? 'Pengguna';

    // Mengambil username
    final String username =
        dataDiri?['username'] ?? '-';

    // Mengambil role
    final String role =
        dataDiri?['role'] ?? 'user';

    // Mengambil status session
    final bool session =
        dataDiri?['session'] ?? false;

    // Mengambil waktu login
    final DateTime waktuLogin =
        dataDiri?['loginTime'] ?? DateTime.now();


    // Format tanggal
    final String tanggal =
        '${waktuLogin.day} '
        '${_namaBulan(waktuLogin.month)} '
        '${waktuLogin.year}';

    // Format jam
    final String jam =
        '${waktuLogin.hour.toString().padLeft(2, '0')}:'
        '${waktuLogin.minute.toString().padLeft(2, '0')}';


    // ==================================================
    // DIALOG
    // ==================================================

    showDialog(
      context: context,

      // User tidak bisa menutup dialog
      // dengan menekan tombol back
      barrierDismissible: false,

      builder: (BuildContext context) {

        return Dialog(
          backgroundColor: Colors.transparent,

          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // ==================================================
                // ICON
                // ==================================================

                Container(
                  width: 80,
                  height: 80,

                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.waving_hand_rounded,

                    color: Colors.deepPurple,

                    size: 42,
                  ),
                ),

                const SizedBox(height: 20),


                // ==================================================
                // JUDUL
                // ==================================================

                const Text(
                  'Selamat Datang! 👋',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 25,

                    fontWeight: FontWeight.bold,

                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 10),


                // ==================================================
                // SAPAAN
                // ==================================================

                Text(
                  'Halo, $nama!',

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 20,

                    fontWeight: FontWeight.w700,

                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 10),


                // ==================================================
                // DESKRIPSI
                // ==================================================

                Text(
                  'Senang melihatmu kembali di aplikasi. '
                  'Kamu berhasil login sebagai $role.',

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 14,

                    height: 1.6,

                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 22),


                // ==================================================
                // INFO LOGIN
                // ==================================================

                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F5FF),

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Column(
                    children: [

                      // Username
                      _infoRow(
                        Icons.person_outline,
                        'Username',
                        username,
                      ),

                      const SizedBox(height: 12),

                      // Tanggal
                      _infoRow(
                        Icons.calendar_today_outlined,
                        'Tanggal Login',
                        tanggal,
                      ),

                      const SizedBox(height: 12),

                      // Jam
                      _infoRow(
                        Icons.access_time_outlined,
                        'Waktu Login',
                        jam,
                      ),

                      const SizedBox(height: 12),

                      // Session
                      _infoRow(
                        Icons.verified_outlined,
                        'Session',
                        session ? 'TRUE' : 'FALSE',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),


                // ==================================================
                // TOMBOL LANJUT
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {

                      // Menutup dialog
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,

                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child: const Text(
                      'Mulai Menjelajah 🚀',

                      style: TextStyle(
                        fontSize: 15,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // ==================================================
  // WIDGET BARIS INFORMASI
  // ==================================================

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {

    return Row(
      children: [

        // Icon
        Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.1),

            borderRadius: BorderRadius.circular(10),
          ),

          child: Icon(
            icon,

            size: 20,

            color: Colors.deepPurple,
          ),
        ),

        const SizedBox(width: 12),


        // Teks
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: const TextStyle(
                  fontSize: 11,

                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,

                style: const TextStyle(
                  fontSize: 14,

                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  // ==================================================
  // NAMA BULAN
  // ==================================================

  String _namaBulan(int bulan) {

    const namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return namaBulan[bulan - 1];
  }


  // ==================================================
  // BUILD
  // ==================================================

  @override
  Widget build(BuildContext context) {

    // Semua halaman aplikasi
    final List<Widget> pages = [

      // Home menerima data dari Login
      HomeScreen(
        dataDiri: dataDiri,
      ),

      // Feeds
      const FeedsScreen(),

      // Mall
      const MallScreen(),

      // Transaction
     TransactionsScreen(),
      
      ProductGrid(),

      // Profile menerima data dari Login
      ProfileScreen(
        dataDiri: dataDiri,
      ),
    ];


    return Scaffold(

      // ==================================================
      // BODY
      // ==================================================

      body: IndexedStack(
        index: currentPageIndex,

        children: pages,
      ),


      // ==================================================
      // BOTTOM NAVIGATION
      // ==================================================

      bottomNavigationBar: Card(

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),

        clipBehavior: Clip.antiAlias,

        margin: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          12,
        ),

        child: NavigationBar(

          // Ketika menu ditekan
          onDestinationSelected:
              (int selectedMenu) {

            setState(() {
              currentPageIndex = selectedMenu;
            });
          },

          // Warna menu aktif
          indicatorColor:
              Theme.of(context)
                  .colorScheme
                  .primary,

          // Index menu aktif
          selectedIndex: currentPageIndex,


          // ==================================================
          // MENU
          // ==================================================

          destinations: const <Widget>[

            // HOME
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
              ),

              icon: Icon(
                Icons.home_outlined,
              ),

              label: 'Home',
            ),


            // FEEDS
            NavigationDestination(
              selectedIcon: Icon(
                Icons.video_collection,
              ),

              icon: Icon(
                Icons.video_collection_outlined,
              ),

              label: 'Feeds',
            ),


            // MALL
            NavigationDestination(
              selectedIcon: Icon(
                Icons.store,
              ),

              icon: Icon(
                Icons.store_outlined,
              ),

              label: 'Mall',
            ),


            // TRANSACTIONS
            NavigationDestination(
              icon: Badge(
                child: Icon(
                  Icons.list_alt_outlined,
                ),
              ),

              label: 'Transactions',
            ),


            // PROFILE
            NavigationDestination(
              icon: Badge(
                label: Text('2'),

                child: Icon(
                  Icons.person,
                ),
              ),

              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}