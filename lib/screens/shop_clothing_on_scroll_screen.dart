import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import go_router

// Helper function to convert Figma color to Flutter Color
Color figmaColor(Map<String, dynamic> color) {
  return Color.fromRGBO(
    (color['r'] * 255).toInt(),
    (color['g'] * 255).toInt(),
    (color['b'] * 255).toInt(),
    color['a'] as double,
  );
}

// Function to generate asset path from Figma ID
String getImagePath(String figmaId) {
  // Figma IDs use ':' and ';', convert to '_' for file paths
  return 'assets/images/I${figmaId.replaceAll(':', '_').replaceAll(';', '_')}.png';
}

class ShopClothingOnScrollScreen extends StatefulWidget {
  static const String routeName = '/shop_clothing_on_scroll';

  const ShopClothingOnScrollScreen({super.key});

  @override
  State<ShopClothingOnScrollScreen> createState() => _ShopClothingOnScrollScreenState();
}

class _ShopClothingOnScrollScreenState extends State<ShopClothingOnScrollScreen> {
  int _selectedIndex = 0; // State for the selected item in the bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation for each bottom navigation item
    switch (index) {
      case 0: // Shop (current screen or home)
        // No navigation needed if already on the shop screen, or navigate to home
        context.go('/shop'); // Example route for root navigation
        break;
      case 1: // Wishlist
        context.go('/wishlist'); // Placeholder route
        break;
      case 2: // Categories
        context.go('/categories'); // Placeholder route
        break;
      case 3: // Cart
        context.go('/cart'); // Placeholder route
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define colors from Figma JSON for consistency
    final primaryTextColor = figmaColor({"r": 0.125490203499794, "g": 0.125490203499794, "b": 0.125490203499794, "a": 1}); // Dark grey
    final blueColor = figmaColor({"r": 0, "g": 0.25882354378700256, "b": 0.8784313797950745, "a": 1}); // Figma blue
    final lightBlueBg = figmaColor({"r": 0.8980392217636108, "g": 0.9215686321258545, "b": 0.9882352948188782, "a": 1}); // Light blueish grey for search field
    final blackColor = figmaColor({"r": 0, "g": 0, "b": 0, "a": 1}); // Black

    // Dummy product data to populate the grid
    final List<Map<String, String>> products = [
      {"image_id": "169:78", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:70", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:48", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:54", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:42", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
      {"image_id": "169:62", "description": "Lorem ipsum dolor sit amet consectetur", "price": "\$17,00"},
    ];

    // Calculate dynamic childAspectRatio for GridView for responsiveness
    // Figma card width: 165, card height: 181
    // Description text height: ~36, Price text height: ~21
    // Spacing estimations based on Figma layout
    const double horizontalPadding = 20.0;
    const double crossAxisSpacing = 20.0;
    const double verticalSpacingImageText = 8.0;
    const double verticalSpacingTextPrice = 4.0;

    final itemWidth = (screenWidth - 2 * horizontalPadding - crossAxisSpacing) / 2;
    // Calculate actual card height keeping original aspect ratio (181/165)
    final cardHeight = itemWidth * (181 / 165);
    // Total item height includes card, description, price, and their vertical spacings
    final itemTotalHeight = cardHeight + verticalSpacingImageText + 36.0 + verticalSpacingTextPrice + 21.0;
    final childAspectRatio = itemWidth / itemTotalHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shop',
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: primaryTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigates to the '/filter' route.
                          context.push('/filter'); // Example navigation
                        },
                        child: Icon(
                          Icons.filter_list, // Interpreted from Figma group 169:136
                          color: primaryTextColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: lightBlueBg,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Clothing',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: blueColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // No navigation, just a UI interaction for removing filter
                          },
                          child: Icon(
                            Icons.close, // Interpreted from Figma 169:90 (Close Icon)
                            size: 16,
                            color: blueColor.withOpacity(0.4),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Navigates to the '/search' route.
                            context.push('/search'); // Example navigation
                          },
                          child: Icon(
                            Icons.tune, // Interpreted from Figma group 169:92
                            color: blueColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Scrollable Content (Clothing Items)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: 20, // Maintain Figma's vertical spacing
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  
                  return GestureDetector(
                    onTap: () {
                      // Navigates to the '/product_detail' route with arguments.
                      context.push('/product_detail', extra: item); // Example navigation
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: cardHeight, // Use calculated responsive card height
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: blackColor.withOpacity(0.1),
                                offset: const Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.asset(
                              getImagePath(item["image_id"]!),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: verticalSpacingImageText),
                        Text(
                          item["description"]!,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: blackColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: verticalSpacingTextPrice),
                        Text(
                          item["price"]!,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 84, // Figma value
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.1),
              offset: const Offset(0, -1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 0, blackColor), // Shop is black
                _buildBottomNavItem(Icons.favorite, 1, blueColor), // Wishlist is blue and filled
                _buildBottomNavItem(Icons.menu, 2, blueColor), // Categories is blue
                _buildBottomNavItem(Icons.shopping_bag_outlined, 3, blueColor), // Cart is blue
              ],
            ),
            // Bottom bar for iPhone X and newer devices
            if (MediaQuery.of(context).padding.bottom > 0)
              Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom * 0.3), // Dynamic margin
                height: 5,
                width: 134,
                decoration: BoxDecoration(
                  color: blackColor,
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper widget for building bottom navigation items
  Widget _buildBottomNavItem(IconData icon, int index, Color iconColor) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: SizedBox(
          height: 50, // Fixed height for tap area
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor, // Use the specific color passed as per Figma
                size: 24,
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    height: 3,
                    width: 25, // Underline bar width
                    decoration: BoxDecoration(
                      color: blueColor, // Underline is always blue for active state
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}