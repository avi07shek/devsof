import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/SingleProductModel.dart';
import '../Detailscreen/detail_screens.dart';
import '../homeScreen/homepage_data.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SingleProductModel> _filteredProducts = [];
// Search query
  String _searchQuery = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (SingleProductModel product in _filteredProducts) {
      String productName = product.productName!;
      String productImage = product.productImage!;
      double productPrice = product.productPrice!;
    }
    _filteredProducts = sigleProductData +
        colothsData +
        shoesData +
        accessoriesData +
        tshirtsData +
        pantsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                _searchQuery = value;
                _filterProducts(_searchQuery);
              },
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: 'Search.....',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _searchQuery.isEmpty
                  ? Container()
                  : _filteredProducts.length == 0
                      ? Text(
                          'No result found Please try with different items',
                          style: TextStyle(fontSize: 24),
                        )
                      : ListView.builder(
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 1,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(_filteredProducts[index]),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    _filteredProducts[index].productImage!),
                                backgroundColor: Colors.transparent,
                              ),
                              title:
                                  Text(_filteredProducts[index].productName!),
                              subtitle: Text(
                                  'Price: ${_filteredProducts[index].productPrice}'),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterProducts(String query) {
    List<SingleProductModel> filteredSingleProductData = sigleProductData
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    List<SingleProductModel> filteredClothsData = colothsData
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    List<SingleProductModel> filteredShoesData = shoesData
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    List<SingleProductModel> filteredAccessoriesData = accessoriesData
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    List<SingleProductModel> filteredTshirtsData = tshirtsData
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    List<SingleProductModel> filteredPantsData = pantsData
        .where((product) =>
            product.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredProducts = filteredSingleProductData +
          filteredClothsData +
          filteredShoesData +
          filteredAccessoriesData +
          filteredTshirtsData +
          filteredPantsData;
    });
  }
}
