import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../Model/SingleProductModel.dart';
import '../../Routes/routes.dart';
import '../../widgets/Single_product_widget.dart';
import '../../widgets/all_category.dart';
import '../../widgets/homeappbar.dart';
import '../../widgets/show_allwidgets.dart';
import '../Cart/addtocart.dart';
import '../Detailscreen/detail_screens.dart';
import '../favorite/favoriteScreen.dart';
import '../profile/profileScreen.dart';
import '../qrScreen/QRScreen.dart';
import '../shoppingCart/shoppingCart.dart';
import 'homepage_data.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static SingleProductModel? signleProductModel;
  late TabController tabController;
  late SingleProductModel data;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    // Addtocart(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      "assets/images/4.png",
      "assets/images/1.png",
      "assets/images/2.png",
      "assets/images/3.png",
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            //temporrary height
            height: 800,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFF57C00),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                )),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 18),
                        indicator: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.white54,
                        labelColor: Colors.white,
                        indicatorWeight: 5,
                        indicatorColor: Colors.white,
                        indicatorPadding: EdgeInsets.all(10),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: 'All',
                          ),
                          Tab(
                            text: 'Hoodies',
                          ),
                          Tab(
                            text: 'Shoes',
                          ),
                          Tab(
                            text: 'Bags',
                          ),
                          Tab(
                            text: 'T-shirt',
                          ),
                          Tab(
                            text: 'Pants',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ShowAllWidget(
                            leftText: "Trending Products",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              primary: true,
                              itemCount: sigleProductData.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                mainAxisExtent: 350,
                              ),
                              itemBuilder: (context, index) {
                                var arrivalDataStore = sigleProductData[index];

                                return SingleProductWidget(
                                    productImage:
                                        arrivalDataStore.productImage!,
                                    productModel:
                                        arrivalDataStore.productModel!,
                                    productName: arrivalDataStore.productName!,
                                    productOldPrice:
                                        arrivalDataStore.productOldPrice!,
                                    productPrice:
                                        arrivalDataStore.productPrice!,
                                    onPressed: () {
                                      PageRouting.goToNextPage(
                                        context: context,
                                        navigateTo: DetailScreen(
                                          arrivalDataStore,
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                      TabBarBar(
                        productData: colothsData,
                      ),
                      TabBarBar(
                        productData: shoesData,
                      ),
                      TabBarBar(
                        productData: accessoriesData,
                      ),
                      TabBarBar(
                        productData: tshirtsData,
                      ),
                      TabBarBar(
                        productData: pantsData,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(
            Icons.qr_code,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QRCodeScreen(),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   currentScreen = DashboardScreen();
                      //   currentTab = 0;
                      // });
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 0
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = CartScreen(data);
                        currentTab = 1;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CartScreen(data),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color:
                              currentTab == 1 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          "Cart",
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 1
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // right tab bar icons
              // Text("Scan and Pay"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   // currentScreen = FavoriteScreen();
                      //   currentTab = 2;
                      // });
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => FavoriteScreen(),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color:
                              currentTab == 2 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          "Favorite",
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 2
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // setState(() {
                      //   // currentScreen = ProfileScreen();
                      //   currentTab = 3;
                      // });
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ProfileScreen(),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 3 ? Colors.deepOrange : Colors.grey,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 3
                                  ? Colors.deepOrange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
