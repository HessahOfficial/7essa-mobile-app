import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hessa/screens/home_screen.dart'; // Replace with the actual path to your HomeScreen file

void main() {
  group('HomeScreen Tests', () {
    // Helper method to set up the widget for testing
    Future<void> _pumpHomeScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );
      await tester.pumpAndSettle(); // Ensure all animations and async operations complete
    }

    testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
      await _pumpHomeScreen(tester);

      // Test that the header is rendered
      expect(find.text('Hello!'), findsOneWidget);
      expect(find.text('James Butler'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);

      // Test that the search bar is rendered
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search...'), findsOneWidget);
      expect(find.byIcon(Icons.tune), findsOneWidget);

      // Test that category tabs are rendered
      expect(find.text('Best for you'), findsOneWidget);
      expect(find.text('Developers'), findsOneWidget);
      expect(find.text('New Added'), findsOneWidget);
      expect(find.text('Best Invest'), findsOneWidget);

      // Test that properties are rendered (initially "Best for you" category)
      expect(find.text('HOT Properties'), findsOneWidget);
      expect(find.text('Apartment'), findsWidgets); // Should find at least one
      expect(find.text('Rest of Properties'), findsOneWidget);

      // Test that the bottom navigation bar is rendered
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Saved'), findsOneWidget);
      expect(find.text('Invest'), findsOneWidget);
      expect(find.text('Wallet'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Search functionality filters properties', (WidgetTester tester) async {
      await _pumpHomeScreen(tester);

      // Initially, all properties in "Best for you" category should be visible
      expect(find.text('Apartment'), findsWidgets);
      expect(find.text('Apartment B'), findsWidgets);
      expect(find.text('Apartment C'), findsWidgets);

      // Enter a search query to filter properties
      await tester.enterText(find.byType(TextField), 'Apartment B');
      await tester.pumpAndSettle();

      // Only "Apartment B" should be visible
      expect(find.text('Apartment B'), findsWidgets);
      expect(find.text('Apartment'), findsNothing); // Should not find "Apartment"
      expect(find.text('Apartment C'), findsNothing);

      // Clear the search query
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      // All properties should be visible again
      expect(find.text('Apartment'), findsWidgets);
      expect(find.text('Apartment B'), findsWidgets);
      expect(find.text('Apartment C'), findsWidgets);
    });

    testWidgets('Category switching updates properties', (WidgetTester tester) async {
      await _pumpHomeScreen(tester);

      // Initially, "Best for you" category is selected
      expect(find.text('Apartment'), findsWidgets);
      expect(find.text('Villa X'), findsNothing); // "Developers" category property

      // Switch to "Developers" category
      await tester.tap(find.text('Developers'));
      await tester.pumpAndSettle();

      // "Developers" properties should be visible
      expect(find.text('Villa X'), findsWidgets);
      expect(find.text('MORSHEDY GROUP'), findsWidgets);
      expect(find.text('Apartment'), findsNothing); // "Best for you" property should not be visible

      // Switch to "New Added" category
      await tester.tap(find.text('New Added'));
      await tester.pumpAndSettle();

      // "New Added" properties should be visible
      expect(find.text('Studio M'), findsWidgets);
      expect(find.text('Villa X'), findsNothing);
      expect(find.text('Apartment'), findsNothing);
    });

    testWidgets('Filter bottom sheet applies filters correctly', (WidgetTester tester) async {
      await _pumpHomeScreen(tester);

      // Initially, all properties in "Best for you" category are visible
      expect(find.text('Apartment'), findsWidgets); // Price: 2670, Size: 2000
      expect(find.text('Apartment C'), findsWidgets); // Price: 29400, Size: 1900

      // Open the filter bottom sheet
      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      // Verify the filter bottom sheet is displayed
      expect(find.text('Filter'), findsOneWidget);
      expect(find.text('Property Size'), findsOneWidget);
      expect(find.text('Property Price'), findsOneWidget);

      // Adjust the max size to 2000 sqft
      await tester.drag(find.byType(Slider), const Offset(-100, 0)); // Drag to reduce size
      await tester.pumpAndSettle();

      // Adjust the price range to 2000-3000
      final rangeSlider = find.byType(RangeSlider);
      await tester.drag(rangeSlider, const Offset(-200, 0)); // Drag to set min price
      await tester.pumpAndSettle();
      await tester.drag(rangeSlider, const Offset(50, 0)); // Drag to set max price
      await tester.pumpAndSettle();

      // Apply the filters
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      // Verify filtered properties
      // "Apartment" (Price: 2670, Size: 2000) should be visible
      expect(find.text('Apartment'), findsWidgets);
      // "Apartment C" (Price: 29400, Size: 1900) should not be visible (price out of range)
      expect(find.text('Apartment C'), findsNothing);
    });

    testWidgets('Bottom navigation bar updates selected index', (WidgetTester tester) async {
      await _pumpHomeScreen(tester);

      // Initially, "Home" is selected (index 0)
      expect(find.byIcon(Icons.home_outlined).first, findsOneWidget);
      expect(tester.widget<Icon>(find.byIcon(Icons.home_outlined).first).color,
          const Color(0xFF4B5EFC)); // Active color

      // Tap on "Saved" (index 1)
      await tester.tap(find.text('Saved'));
      await tester.pumpAndSettle();

      // "Saved" should be selected
      expect(tester.widget<Icon>(find.byIcon(Icons.bookmark_border_outlined).first).color,
          const Color(0xFF4B5EFC)); // Active color
      expect(tester.widget<Icon>(find.byIcon(Icons.home_outlined).first).color,
          Colors.grey); // Inactive color

      // Tap on "Invest" (index 2)
      await tester.tap(find.text('Invest'));
      await tester.pumpAndSettle();

      // "Invest" should be selected
      expect(tester.widget<Icon>(find.byIcon(Icons.bar_chart).first).color,
          Colors.white); // FAB icon color
      expect(tester.widget<Text>(find.text('Invest').first).style?.color,
          const Color(0xFF4B5EFC)); // Active color
    });
  });
}