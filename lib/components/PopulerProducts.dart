import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Widgets/ProductBox.dart';
import '../loading/productboxLoading.dart';
import '../provider/products/GetProductProvider.dart';

class PopulerProduct extends StatelessWidget {
  const PopulerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetProductProvider>(
      create: (_) => GetProductProvider(),
      child: Consumer(
        builder: (context, GetProductProvider value, child) {
          if (value.isLoading) {
            return productBoxLaoding(context);
          }
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: value.productsList.length,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width / 600,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(Uri(
                              path: '/product/' +
                                  value.productsList[index]['_id'])
                          .toString());
                    },
                    child: ProductBox(data: value.productsList[index])),
              );
            },
          );
        },
      ),
    );
  }
}
