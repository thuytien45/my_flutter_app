import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_tile.dart';
import 'product_form_screen.dart';

class ProductListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('List Products')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductFormScreen()),
          );
          ref.refresh(productListProvider); // Refresh list on return
        },
      ),
      body: productList.when(
        data:
            (products) => SingleChildScrollView(
              child: DataTable(
                columnSpacing: 16.0,
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue.shade100,
                ),
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                dataRowHeight: 60,
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Price')),
                ],
                rows:
                    products.asMap().entries.map<DataRow>((entry) {
                      final index = entry.key; // Get the index of the product
                      final product = entry.value; // Get the product
                      return DataRow(
                        cells: [
                          DataCell(
                            Text((index + 1).toString()),
                          ), // Auto-incremented ID (index + 1)
                          DataCell(Text(product.name)),
                          DataCell(Text('\$${product.price}')),
                        ],
                      );
                    }).toList(),
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
