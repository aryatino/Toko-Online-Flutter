import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/dummy/dummy_transaksi.dart';
// Import file halaman tujuan navigasi
import 'detail_transaksi_screen.dart';
import 'lacak_pesanan_screen.dart';
import 'tanya_penjual_screen.dart';
import 'nilai_produk_screen.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({super.key});

  String formatRupiah(int harga) {
    return 'Rp ${harga.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match.group(1)}.')}';
  }

  // ==========================================
  // METHOD NAVIGASI HALAMAN
  // ==========================================
  void prosesSelesai(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NilaiProdukScreen()),
    );
  }

  void lacakPesanan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LacakPesananScreen()),
    );
  }

  void tanyaPenjual(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TanyaPenjualScreen()),
    );
  }

  void pindahDetailTransaksi(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DetailTransaksiScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaksi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final item = transactions[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Tanggal & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.tanggal,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(item.status).withAlpha(35),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: getStatusColor(item.status).withAlpha(200),
                          ),
                        ),
                        child: Text(
                          item.status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(item.status),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16), // Garis pembatas halus
                  // Row 2: Foto & Informasi Barang
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.foto,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 24,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '1 barang',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row 3: Total Belanja & Tombol Detail
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Belanja',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            formatRupiah(item.harga),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          switch (item.status) {
                            case 'Selesai':
                              prosesSelesai(context);
                              break;
                            case 'Dikirim':
                              lacakPesanan(context);
                              break;
                            case 'Diproses':
                              tanyaPenjual(context);
                              break;
                            case 'Dikemas':
                              tanyaPenjual(context);
                              break;
                            case 'Dibatalkan':
                              pindahDetailTransaksi(context);
                              break;
                            default:
                              pindahDetailTransaksi(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(getButtonText(item.status)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Dikirim':
        return Colors.blue;
      case 'Diproses':
        return Colors.purple;
      case 'Dikemas':
        return Colors.orange;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getButtonText(String status) {
    switch (status) {
      case 'Selesai':
        return 'Nilai';
      case 'Dikirim':
        return 'Lacak';
      case 'Diproses':
        return 'Tanya Penjual';
      case 'Dikemas':
        return 'Tanya Penjual';
      case 'Dibatalkan':
        return 'Beli Lagi';
      default:
        return 'Detail';
    }
  }
}
