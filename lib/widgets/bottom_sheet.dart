import 'package:flutter/material.dart';
import 'package:flutter_mock_mid/models/model.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final APIDataModel product;

  const ProductDetailsBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: description(product),
    );
  }

  Widget description(APIDataModel obj) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50, // Set the width of the image as needed
                height: 50, // Set the height of the image as needed
                child: Image.network(
                  obj.imageLink ?? '',
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(obj.name ?? ''),
                    subtitle: Text(obj.description?.trim() ?? ''),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Brand: ${obj.brand ?? ''}'),
                    Text('Product Type: ${obj.productType ?? ''}'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Price: \$${obj.price ?? ''}'),
                    Text('Rating: ${obj.rating ?? ''}'),
                  ],
                ),
              ),
            ],
          ),
          if (obj.productColors != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (ProductColors color in obj.productColors!) circle(color)
              ],
            ),
        ],
      ),
    );
  }

  Widget circle(ProductColors color) {
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Color(int.parse('0xFF${color.hexValue!.replaceAll('#', '')}')),
        shape: BoxShape.circle,
      ),
    );
  }
}
