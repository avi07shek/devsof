import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:hamropasal/Model/favorite_model.dart';
import 'package:provider/provider.dart';

import '../../Model/SingleProductModel.dart';
import '../../Routes/routes.dart';
import '../../view_models/auth_view_model.dart';
import '../../view_models/global_auth_view_model.dart';
import '../../widgets/Single_product_widget.dart';
import 'detailscreen_data.dart';

class DetailScreen extends StatefulWidget {
  final SingleProductModel data;
  DetailScreen(this.data);
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String dropdownvalue = 'Colors';
  String sizevalue = 'Size';
  // List of items in our dropdown menu
  var items1 = [
    'Size',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];
  var items = [
    'Colors',
    'Red',
    'Green',
    'Blue',
    'White',
    'Black',
  ];

  bool isFavourite = false;
  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  String? productId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
      final args = ModalRoute.of(context)!.settings.arguments.toString();
      setState(() {
        productId = args;
      });
      print(args);
      getData(args);
    });
    super.initState();
  }

  Future<void> getData(String productId) async {
    _ui.loadState(true);
    try {
      await _authViewModel.getFavoritesUser();
    } catch (e) {}
    _ui.loadState(false);
  }

  Future<void> favoritePressed() async {
    _ui.loadState(true);
    try {
      final FavoriteModel data = FavoriteModel(
        productImage: widget.data.productImage,
        productName: widget.data.productName,
        productPrice: widget.data.productPrice.toString(),
        userId: _authViewModel.loggedInUser!.userId,
      );
      await _authViewModel.favoriteAction(data);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Favorite updated.")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong. Please try again.")));
      print(e);
    }
    _ui.loadState(false);
  }

  Future<void> addToCart() async {
    _ui.loadState(true);
    try {
      final SingleProductModel data = SingleProductModel(
        productImage: widget.data.productImage,
        productName: widget.data.productName,
        productPrice: widget.data.productPrice,
        userId: _authViewModel.loggedInUser!.userId,
      );
      await _authViewModel.addMyProductToCart(data);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Added to cart.")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong. Please try again.")));
      print(e);
    }
    _ui.loadState(false);
  }

  PreferredSize buildAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "HamroPasal",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              size: 30,
              color: isFavourite != null ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              favoritePressed();
            },
          ),
        ],
      ),
    );
  }

  buildListTile() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.data.productName!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.data.productModel!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.productPrice.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.data.productOldPrice.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  buildProductImages() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(children: <Widget>[
              Image.network(
                widget.data.productImage!,
                fit: BoxFit.cover,
                width: 450,
              ),
            ]),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 15, top: 15),
                  child: Image.network(widget.data.productSecondImage!),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 15, top: 15),
                  child: Image.network(widget.data.productThirdImage!),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 15, top: 15),
                  child: Image.network(widget.data.productFourImage!),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildColorsAndSize() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: sizevalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items1.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    sizevalue = newValue!;
                  });
                },
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBottomGridView() {
    return Container(
      height: 240,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: true,
        itemCount: detailScreenData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          var data = detailScreenData[index];
          return SingleProductWidget(
            onPressed: () {
              PageRouting.goToNextPage(
                context: context,
                navigateTo: DetailScreen(
                  data,
                ),
              );
            },
            productImage: data.productImage!,
            productModel: data.productModel!,
            productName: data.productName!,
            productOldPrice: data.productOldPrice!,
            productPrice: data.productPrice!,
          );
        },
      ),
    );
  }

  buildAddtoCart() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: MaterialButton(
        elevation: 0,
        height: 50,
        color: Colors.orange,
        shape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          addToCart();
        },
        child: Text(
          "Add to Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  buildMayLikeYou() {
    return ListTile(
      leading: Text(
        "You may also like",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        "Show All",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          buildProductImages(),
          buildListTile(),
          buildColorsAndSize(),
          buildAddtoCart(),
          buildMayLikeYou(),
          buildBottomGridView(),
        ],
      ),
    );
    ;
  }
}
