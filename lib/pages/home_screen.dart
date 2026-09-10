import 'package:flutter/material.dart';
import '../data/dummy/dummy_kategori.dart';
import '../data/dummy/dummy_produk.dart';
import '../data/models/model_kategori.dart';
import '../data/models/model_produk.dart';
import '../widgets/my_app_bar.dart';
import 'detail_product_screen.dart';

// =====================================================
// HOME SCREEN
// =====================================================

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // ===================================================
  // DATA KATEGORI
  // ===================================================

  // ===================================================
  // DATA PRODUK
  // ===================================================

  // ===================================================
  // BUILD
  // ===================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================
            // JUDUL KATEGORI
            // =================================================
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Kategori',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // =================================================
            // LIST KATEGORI
            // =================================================
            SizedBox(
              height: 120,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                padding: const EdgeInsets.symmetric(horizontal: 16),

                itemCount: categories.length,

                itemBuilder: (context, index) {
                  final category = categories[index];

                  return _categoryItem(category);
                },
              ),
            ),

            // =================================================
            // JARAK
            // =================================================
            const SizedBox(height: 25),

            // =================================================
            // JUDUL PRODUK TERBARU
            // =================================================
            const Center(
              child: Text(
                'Produk Terbaru',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // Garis kecil di bawah judul
            const SizedBox(height: 8),

            Center(
              child: Container(
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // =================================================
            // JARAK SEBELUM PRODUK
            // =================================================
            const SizedBox(height: 20),

            // =================================================
            // GRID PRODUK
            // =================================================
            GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

              itemCount: products.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                crossAxisSpacing: 12,

                mainAxisSpacing: 12,

                childAspectRatio: 0.68,
              ),

              itemBuilder: (context, index) {
                final product = products[index];

                return _productItemView(product, context);
              },
            ),

            // =================================================
            // JARAK BAWAH
            // =================================================
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CATEGORY ITEM
  // =====================================================

  Widget _categoryItem(Category category) {
    return Container(
      width: 95,

      margin: const EdgeInsets.only(right: 12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // GAMBAR KATEGORI
          Container(
            width: 55,
            height: 55,

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.grey.shade100,

              shape: BoxShape.circle,
            ),

            child: Image.network(
              category.image,

              fit: BoxFit.contain,

              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // NAMA KATEGORI
          Text(
            category.name,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // PRODUCT ITEM
  // =====================================================

  Widget _productItemView(Product product, BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

      clipBehavior: Clip.antiAlias,

      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(product.name),
                content: Text('Apakah kamu ingin melihat produk ini?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailProductScreen(product: product),
                        ),
                      );
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =================================================
            // GAMBAR PRODUK
            // =================================================
            Expanded(
              child: Image.network(
                product.image,

                width: double.infinity,

                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            // =================================================
            // INFORMASI PRODUK
            // =================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // NAMA PRODUK
                  Text(
                    product.name,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // HARGA
                  Text(
                    'Rp ${product.price}',

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // RATING
                  const Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.orange),

                      SizedBox(width: 4),

                      Text('4.8', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
