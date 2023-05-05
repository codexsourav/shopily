import 'package:ecomarce/provider/products/SearchProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Widgets/ProductBox.dart';
import '../loading/productboxLoading.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(),
      child: Consumer(
        builder: (context, SearchProvider model, _) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: const Color.fromARGB(255, 0, 0, 0),
                        ),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: searchText,
                    onEditingComplete: () {
                      if (searchText.text.isNotEmpty) {
                        model.getsearch(searchText.text);
                      }
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.clear),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: model.query.isEmpty
                ? const SizedBox()
                : Builder(
                    builder: (context) {
                      if (model.isLoading) {
                        return productBoxLaoding(context);
                      } else if (model.searchProducts.length == 0) {
                        return const Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 25),
                          child: Text(
                            'No Products Found!',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 63, 63, 63)),
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 25),
                            child: Text(
                              'Search : ${searchText.text}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 63, 63, 63)),
                            ),
                          ),
                          const SizedBox(height: 25),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.searchProducts.length,
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width / 600,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                    onTap: () {
                                      GoRouter.of(context).push(Uri(
                                              path: '/product/' +
                                                  model.searchProducts[index]
                                                      ['_id'])
                                          .toString());
                                    },
                                    child: ProductBox(
                                        data: model.searchProducts[index])),
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
// 0121134214