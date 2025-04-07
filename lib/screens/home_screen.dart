import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hessa/screens/wallet-page.dart';
import 'package:provider/provider.dart';

import 'developer_profile_screen.dart';
import 'SavedPropertiesPage.dart';
import 'package:hessa/saved_properties_provider.dart';

class FilterOptions {
  final double maxSize;
  final double minPrice;
  final double maxPrice;

  FilterOptions({
    this.maxSize = 5000,
    this.minPrice = 0,
    this.maxPrice = 50000,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  FilterOptions _filterOptions = FilterOptions();
  String _searchQuery = '';
  late PageController _pageController;

  final List<String> _categories = [
    'Best for you',
    'Developers',
    'New Added',
    'Best Invest'
  ];
  final List<Map<String, dynamic>> _developers = [
    {
      'title': 'MORSHEDY GROUP',
      'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
      'properties': [
        {
          'name': 'Dup Apartment',
          'price': 2670, 'size': 2000, 'bedrooms': 4, 'bathrooms': 1,
          'location': '28W Street, NY, New York',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
        },
        {
          'name': 'Dup p',
          'location': '28W Street, NY, New York',
          'size': '2000sqft',
          'price': '\$267000',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
          'bedrooms': 3,
          'bathrooms': 2,
        },
        {
          'name': 'Dup h',
          'location': '28W Street, NY, New York',
          'size': '2000sqft',
          'price': '\$267000',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
          'bedrooms': 3,
          'bathrooms': 2,
        },
      ],
    },
    {
      'title': 'ANA GROUP',
      'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
      'properties': [
        {
          'name': 'Dup Apartment',
          'location': '28W Street, NY, New York',
          'size': '2000sqft',
          'price': '\$267000',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
          'bedrooms': 3,
          'bathrooms': 2,
        },
        {
          'name': 'Dup p',
          'location': '28W Street, NY, New York',
          'size': '2000sqft',
          'price': '\$267000',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
          'bedrooms': 3,
          'bathrooms': 2,
        },
        {
          'name': 'Dup h',
          'location': '28W Street, NY, New York',
          'size': '2000sqft',
          'price': '\$267000',
          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
          'bedrooms': 3,
          'bathrooms': 2,
        },
      ],
    },
  ];

  final Map<String, List<Map<String, dynamic>>> _properties = {
    'Best for you': [
      {'name': 'Apartment', 'price': 2670, 'size': 2000, 'bedrooms': 4, 'bathrooms': 1},
      {'name': 'Apartment B', 'price': 2550, 'size': 2100, 'bedrooms': 3, 'bathrooms': 2},
      {'name': 'Apartment C', 'price': 29400, 'size': 1900, 'bedrooms': 4, 'bathrooms': 1},
      {'name': 'Apartment D', 'price': 28900, 'size': 2200, 'bedrooms': 5, 'bathrooms': 2},
      {'name': 'Apartment E', 'price': 2656, 'size': 2000, 'bedrooms': 4, 'bathrooms': 1},{'name': 'Apartment 5', 'price': 2656, 'size': 2000, 'bedrooms': 4, 'bathrooms': 1},{'name': 'Apartment 7', 'price': 2656, 'size': 2000, 'bedrooms': 4, 'bathrooms': 1},{'name': 'Apartment 9', 'price': 2656, 'size': 2000, 'bedrooms': 4, 'bathrooms': 1}
    ],

    'Developers': [

    ],
    'New Added': [
      {'name': 'Studio M', 'price': 1500, 'size': 800, 'bedrooms': 1, 'bathrooms': 1},
      {'name': 'Studio N', 'price': 1600, 'size': 850, 'bedrooms': 1, 'bathrooms': 1},
      {'name': 'Studio O', 'price': 150, 'size': 820, 'bedrooms': 1, 'bathrooms': 1},
      {'name': 'Studio P', 'price': 1650, 'size': 870, 'bedrooms': 1, 'bathrooms': 1},
      {'name': 'Studio Q', 'price': 1700, 'size': 900, 'bedrooms': 2, 'bathrooms': 1},
    ],
    'Best Invest': [
      {'name': 'Penthouse J', 'price': 503, 'size': 4000, 'bedrooms': 6, 'bathrooms': 4},
      {'name': 'Penthouse K', 'price': 484, 'size': 3800, 'bedrooms': 5, 'bathrooms': 3},
      {'name': 'Penthouse L', 'price': 924, 'size': 4100, 'bedrooms': 6, 'bathrooms': 4},
      {'name': 'Penthouse M', 'price': 1943, 'size': 3700, 'bedrooms': 5, 'bathrooms': 3},
      {'name': 'Penthouse N', 'price': 4913, 'size': 4200, 'bedrooms': 7, 'bathrooms': 5},
    ],
  };

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
  List<Map<String, dynamic>> _filterProperties(List<Map<String, dynamic>> properties) {
    return properties.where((property) {
      final bool matchesSearch = _searchQuery.isEmpty ||
          property['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final bool matchesSize = property['size'] <= _filterOptions.maxSize;
      final bool matchesPrice = property['price'] >= _filterOptions.minPrice &&
          property['price'] <= _filterOptions.maxPrice;
      return matchesSearch && matchesSize && matchesPrice;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(
        initialOptions: _filterOptions,
        onApply: (options) {
          setState(() {
            _filterOptions = options;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedPropertiesProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildHomePage(),
              SavedPropertiesPage(),
              _buildInvestPage(),
              WalletPage(),
              _buildSettingsPage(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }
  Widget _buildHomePage() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildCategoryTabs(),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSectionContent(),
            ),
          ),
        ),
      ],
    );
  }

  // Placeholder Pages


  Widget _buildInvestPage() {
    return Center(
      child: Text(
        'Investment Options',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWalletPage() {
    return Center(
      child: Text(
        'Wallet',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingsPage() {
    return Center(
      child: Text(
        'Settings',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _buildBottomNavigationBar() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final double bottomPadding = mediaQuery.padding.bottom;
    final bool isTablet = screenWidth > 600;

    final double navBarHeight = isLandscape
        ? screenHeight * 0.15
        : (isTablet ? screenHeight * 0.11 : screenHeight * 0.12);
    final double minNavBarHeight = 72.0 + bottomPadding;
    final double finalNavBarHeight = math.max(navBarHeight, minNavBarHeight);

    final double baseFabSize = screenWidth * 0.14;
    final double minFabSize = 56.0;
    final double maxFabSize = 80.0;
    final double fabSize = math.min(maxFabSize, math.max(minFabSize,
        isTablet ? baseFabSize * 0.9 : baseFabSize));

    final double baseIconSize = screenWidth * 0.065;
    final double minIconSize = 28.0;
    final double maxIconSize = 40.0;
    final double iconSize = math.min(maxIconSize, math.max(minIconSize, baseIconSize));

    final double baseTitleSize = screenWidth * 0.03;
    final double minTitleSize = 10.0;
    final double maxTitleSize = 14.0;
    final double titleSize = math.min(maxTitleSize, math.max(minTitleSize, baseTitleSize));

    final double horizontalPadding = screenWidth * 0.04;
    final double iconPadding = isTablet ? 10.0 : 8.0;
    final double fabElevation = fabSize * 0.9;

    final List<String> titles = ['Home', 'Saved', 'Invest', 'Wallet', 'Settings'];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: finalNavBarHeight,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isLandscape ? 4.0 : 0.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navBarItemWithTitle(
                        icon: Icons.home_outlined,
                        title: titles[0],
                        index: 0,
                        isSelected: _selectedIndex == 0,
                        iconSize: iconSize,
                        padding: iconPadding,
                        fontSize: titleSize,
                      ),
                      _navBarItemWithTitle(
                        icon: Icons.bookmark_border_outlined,
                        title: titles[1],
                        index: 1,
                        isSelected: _selectedIndex == 1,
                        iconSize: iconSize,
                        padding: iconPadding,
                        fontSize: titleSize,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: fabSize * 0.7),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navBarItemWithTitle(
                        icon: Icons.account_balance_wallet_outlined,
                        title: titles[3],
                        index: 3,
                        isSelected: _selectedIndex == 3,
                        iconSize: iconSize,
                        padding: iconPadding,
                        fontSize: titleSize,
                      ),
                      _navBarItemWithTitle(
                        icon: Icons.settings_outlined,
                        title: titles[4],
                        index: 4,
                        isSelected: _selectedIndex == 4,
                        iconSize: iconSize,
                        padding: iconPadding,
                        fontSize: titleSize,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: finalNavBarHeight - fabElevation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: fabSize,
                width: fabSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5EFC),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(75, 94, 252, 0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _onNavItemTapped(2),
                    child: Center(
                      child: Icon(
                        Icons.bar_chart,
                        color: Colors.white,
                        size: fabSize * 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                titles[2],
                style: TextStyle(
                  color: _selectedIndex == 2 ? const Color(0xFF4B5EFC) : Colors.grey,
                  fontSize: titleSize,
                  fontWeight: _selectedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _navBarItemWithTitle({
    required IconData icon,
    required String title,
    required int index,
    required bool isSelected,
    required double iconSize,
    required double padding,
    required double fontSize,
  }) {
    final Color activeColor = const Color(0xFF4B5EFC);
    final Color inactiveColor = Colors.grey;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => _onNavItemTapped(index),
        child: Container(
          padding: EdgeInsets.all(padding),
          constraints: BoxConstraints(
            minWidth: iconSize * 1.8,
            minHeight: iconSize * 1.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: iconSize,
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? activeColor : inactiveColor,
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'James Butler',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.grey[700], size: 28),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF4B5EFC),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.tune, color: Colors.white, size: 24),
            onPressed: _showFilterBottomSheet,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: _selectedCategoryIndex == index
                    ? Color.fromRGBO(75, 94, 252, 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? const Color(0xFF4B5EFC)
                      : Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionContent() {
    // Ensure selectedCategory is valid
    String selectedCategory = _categories.isNotEmpty
        ? _categories[_selectedCategoryIndex]
        : 'DefaultCategory';

    // Get properties for the selected category
    List<Map<String, dynamic>> properties = _properties[selectedCategory] ?? [];
    List<Map<String, dynamic>> filteredProperties = _filterProperties(properties);

    if (selectedCategory == 'Developers') {
      // Ensure _developers is properly passed
      return _buildDeveloperProperties(context, _developers);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('HOT Properties'),
          filteredProperties.isNotEmpty
              ? _buildHotProperties(filteredProperties.take(3).toList())
              : const Text('No properties match your filters.'),
          _buildSectionTitle('Rest of Properties'),
          filteredProperties.length > 3
              ? _buildPropertyList(filteredProperties.skip(3).toList())
              : const Text('No more properties to display.'),
        ],
      );
    }
  }


  Widget _buildSectionTitle(String title) {
    if (title.contains('HOT')) {
      final parts = title.split('HOT');
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: parts[0],
                style: TextStyle(color: Colors.black87),
              ),
              TextSpan(
                text: 'HOT',
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text: parts[1],
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildHotProperties(List<Map<String, dynamic>> properties) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double viewportFraction = 0.7;
    final double cardWidth = screenWidth * viewportFraction > 280 ? 280 : screenWidth * viewportFraction;

    final PageController pageController = PageController(
      viewportFraction: viewportFraction,
      initialPage: 0,
    );

    final ValueNotifier<double> currentPageNotifier = ValueNotifier<double>(0);

    void setupPageController() {
      pageController.addListener(() {
        currentPageNotifier.value = pageController.page ?? 0;
      });
    }

    void startAutoScroll() {
      Timer.periodic(Duration(seconds: 3), (timer) {
        if (pageController.hasClients) {
          if (pageController.page?.round() == properties.length - 1) {
            pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 1200),
              curve: Curves.easeOutQuint,
            );
          } else {
            pageController.nextPage(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutBack,
            );
          }
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupPageController();
      startAutoScroll();
    });

    final double carouselHeight = screenWidth < 400 ? 320 : 360;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: carouselHeight,
          child: PageView.builder(
            controller: pageController,
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return ValueListenableBuilder<double>(
                valueListenable: currentPageNotifier,
                builder: (context, value, child) {
                  final double distanceFromCenter = (index - value).abs();
                  final double scale = 1.0 - (distanceFromCenter * 0.15);
                  final double opacity = 1.0 - (distanceFromCenter * 0.4);
                  final double yOffset = distanceFromCenter * 10;

                  return Transform.translate(
                    offset: Offset(0, yOffset),
                    child: Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity.clamp(0.6, 1.0),
                        child: Center(
                          child: _buildHotPropertyCard(properties[index], cardWidth),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 16),
        ValueListenableBuilder<double>(
          valueListenable: currentPageNotifier,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                properties.length,
                    (index) {
                  final bool isActive = (index == value.round());
                  final double size = isActive ? 10 : 8;

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHotPropertyCard(Map<String, dynamic> property, double cardWidth) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.7;
    final double finalWidth = cardWidth > maxWidth ? maxWidth : cardWidth;

    final double titleSize = finalWidth < 260 ? 14 : 16;
    final double priceSize = finalWidth < 260 ? 16 : 18;
    final double locationSize = finalWidth < 260 ? 11 : 12;

    final double imageHeight = finalWidth * 0.6;
    final double detailsHeight = finalWidth < 260 ? 80 : 90;
    final double totalCardHeight = imageHeight + detailsHeight;

    return Consumer<SavedPropertiesProvider>(
      builder: (context, provider, child) {
        final bool isSaved = provider.isPropertySaved(property);

        return Container(
          width: finalWidth,
          height: totalCardHeight,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 15,
                spreadRadius: 2,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: Color(0xFF4B5EFC),
                            size: 16,
                          ),
                          onPressed: () {
                            provider.toggleSaveProperty(property);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: detailsHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: finalWidth * 0.05,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        property['name'],
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: locationSize, color: Colors.grey[600]),
                          SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              'New York, USA',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: locationSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 1),
                      _buildCardBottomRow(property, finalWidth, priceSize),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardBottomRow(Map<String, dynamic> property, double cardWidth, double priceSize) {
    final bool isSmallCard = cardWidth < 250;

    if (isSmallCard) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${property['price']}LE / share',
            style: TextStyle(
              fontSize: priceSize,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B5EFC),
            ),
          ),
          SizedBox(height: 2),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${property['price']}LE / share ',
            style: TextStyle(
              fontSize: priceSize,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B5EFC),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildPropertyList(List<Map<String, dynamic>> properties) {
    return Column(
      children: properties.map((property) => _buildPropertyItem(property)).toList(),
    );
  }

  Widget _buildPropertyItem(Map<String, dynamic> property) {

    return Consumer<SavedPropertiesProvider>(
    builder: (context, provider, child) {
      final bool isSaved = provider.isPropertySaved(property);
      print("saved ukkuu properties: ${provider.savedProperties}");
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: Color(0xFF4B5EFC),
                          size: 20,
                        ),
                        onPressed: () {
                          provider.toggleSaveProperty(property);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '2BW Street, NY, New York',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${property['price']}LE / share',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.square_foot, size: 20,
                              color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${property['size']} sqft',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.king_bed, size: 20,
                              color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${property['bedrooms']}',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                              Icons.bathtub, size: 20, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${property['bathrooms']}',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }  );
  }

  Widget _buildDeveloperProperties(BuildContext context, List<Map<String, dynamic>> developers) {
    if (developers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text('No developers available.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: developers.length,
      itemBuilder: (context, index) {
        final developer = developers[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeveloperProfilePage(
                  name: developer['title'],
                  properties: developer['properties'],
                  logo: developer['logo'],
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.network(
                  developer['logo'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    developer['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
              ],
            ),
          ),
        );
      },
    );
  }


}

class FilterBottomSheet extends StatefulWidget {
  final FilterOptions initialOptions;
  final Function(FilterOptions) onApply;

  const FilterBottomSheet({
    Key? key,
    required this.initialOptions,
    required this.onApply,
  }) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _maxSize;
  late double _minPrice;
  late double _maxPrice;

  @override
  void initState() {
    super.initState();
    _maxSize = widget.initialOptions.maxSize;
    _minPrice = widget.initialOptions.minPrice;
    _maxPrice = widget.initialOptions.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Filter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Property Size',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Up to ${(_maxSize.round() / 1000).toStringAsFixed(1)}K sqft',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Slider(
            value: _maxSize,
            min: 0,
            max: 5000,
            divisions: 50,
            activeColor: const Color(0xFF4B5EFC),
            inactiveColor: Colors.grey[300],
            onChanged: (value) {
              setState(() {
                _maxSize = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Property Price',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LOW',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'HIGH',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 50000,
            divisions: 50,
            activeColor: const Color(0xFF4B5EFC),
            inactiveColor: Colors.grey[300],
            labels: RangeLabels(
              '${(_minPrice.round() / 1000).toStringAsFixed(1)}K',
              '${(_maxPrice.round() / 1000).toStringAsFixed(1)}K',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(75, 94, 252, 0.1), // Equivalent to 0xFF4B5EFC with 10% opacity
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  '\$${_minPrice.round()}',
                  style: TextStyle(
                    color: Color(0xFF4B5EFC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(75, 94, 252, 0.1), // Equivalent to 0xFF4B5EFC with 10% opacity
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  '\$${_maxPrice.round()}',
                  style: TextStyle(
                    color: Color(0xFF4B5EFC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _maxSize = 5000;
                    _minPrice = 0;
                    _maxPrice = 50000;
                  });
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onApply(FilterOptions(
                    maxSize: _maxSize,
                    minPrice: _minPrice,
                    maxPrice: _maxPrice,
                  ));
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B5EFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

