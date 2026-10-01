import 'package:flutter/material.dart';

class LacakPesananScreen extends StatelessWidget {
  const LacakPesananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy riwayat pengiriman
    final List<Map<String, String>> trackingList = [
      {
        'time': '28 Sep 2026, 14:30 WIB',
        'status': 'Kurir sedang menuju ke lokasi penerima',
        'sub': 'Pesanan dibawa oleh Kurir (Budi - 08123456789)'
      },
      {
        'time': '28 Sep 2026, 08:15 WIB',
        'status': 'Pesanan tiba di Hub Jakarta Selatan',
        'sub': 'Penyortiran selesai'
      },
      {
        'time': '27 Sep 2026, 20:00 WIB',
        'status': 'Pesanan dikirim dari Gudang Utama',
        'sub': 'Dalam perjalanan ke Jakarta'
      },
      {
        'time': '27 Sep 2026, 15:10 WIB',
        'status': 'Pesanan telah diserahkan ke jasa kirim',
        'sub': 'JNE Express - NO. RESI: JNE1234567890'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lacak Pesanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Kurir & Resi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Pengiriman',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Kurir', style: TextStyle(color: Colors.grey)),
                        Text('JNE Express (Reguler)', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('No. Resi', style: TextStyle(color: Colors.grey)),
                        Text('JNE1234567890', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Riwayat Pengiriman',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Timeline Riwayat
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: trackingList.length,
              itemBuilder: (context, index) {
                final item = trackingList[index];
                final isFirst = index == 0;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kolom Indikator Garis/Titik Timeline
                    Column(
                      children: [
                        Icon(
                          isFirst ? Icons.radio_button_checked : Icons.circle,
                          size: isFirst ? 20 : 12,
                          color: isFirst ? Colors.blueAccent : Colors.grey.shade400,
                        ),
                        if (index != trackingList.length - 1)
                          Container(
                            width: 2,
                            height: 60,
                            color: Colors.grey.shade300,
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Detail Teks Status
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['status']!,
                              style: TextStyle(
                                fontWeight: isFirst ? FontWeight.bold : FontWeight.normal,
                                color: isFirst ? Colors.black : Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['sub']!,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['time']!,
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}