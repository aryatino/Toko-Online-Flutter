import 'package:flutter/material.dart';

class NilaiProdukScreen extends StatefulWidget {
  const NilaiProdukScreen({super.key});

  @override
  State<NilaiProdukScreen> createState() => _NilaiProdukScreenState();
}

class _NilaiProdukScreenState extends State<NilaiProdukScreen> {
  int _userRating = 5;
  final TextEditingController _ulasanController = TextEditingController();

  final List<Map<String, dynamic>> _daftarUlasan = [
    {
      'nama': 'Andi Pratama',
      'rating': 5,
      'tanggal': '20 Sep 2026',
      'ulasan':
          'Barangnya original, sangat nyaman dipakai lari. Pengiriman super cepat!',
      'avatar': 'assets/images/ppandi.webp',
    },
    {
      'nama': 'Siti Rahma',
      'rating': 4,
      'tanggal': '19 Sep 2026',
      'ulasan':
          'Sepatunya bagus dan sesuai ukuran. Hanya saja ukurannya sedikit sempit di bagian depan.',
      'avatar': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'nama': 'Budi Santoso',
      'rating': 5,
      'tanggal': '15 Sep 2026',
      'ulasan': 'Kualitas mantap, sol empuk banget. Recommended seller!',
      'avatar': 'https://i.pravatar.cc/150?img=12',
    },
  ];

  void _kirimUlasan() {
    if (_ulasanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan tulis ulasan kamu terlebih dahulu'),
        ),
      );
      return;
    }

    setState(() {
      _daftarUlasan.insert(0, {
        'nama': 'Saya',
        'rating': _userRating,
        'tanggal': 'Hari ini',
        'ulasan': _ulasanController.text,
        'avatar': 'https://i.pravatar.cc/150?img=33',
      });
      _ulasanController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Terima kasih! Ulasan berhasil dikirim.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Penilaian Produk'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Produk yang Dinilai
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/100',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sepatu Running',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Variasi: Merah, Size 42',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Form Beri Rating
            const Text(
              'Beri Penilaian Kamu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Bintang Pilihan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              _userRating = index + 1;
                            });
                          },
                          icon: Icon(
                            index < _userRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 32,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    // Textbox Ulasan
                    TextField(
                      controller: _ulasanController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            'Tulis ulasan mengenai kualitas produk ini...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Tombol Kirim
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _kirimUlasan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Kirim Ulasan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Ringkasan Rating & Ulasan Pengguna Lain
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ulasan Pembeli',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text(
                      '4.8 / 5.0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // List Ulasan Lainnya
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _daftarUlasan.length,
              itemBuilder: (context, index) {
                final ulasan = _daftarUlasan[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(ulasan['avatar']),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ulasan['nama'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    ulasan['tanggal'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (starIndex) => Icon(
                                  starIndex < ulasan['rating']
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ulasan['ulasan'],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
