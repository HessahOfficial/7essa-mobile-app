import 'package:flutter/material.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_property_card.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/generated/l10n.dart';

class MatchedPropertyScreen extends StatefulWidget {
  const MatchedPropertyScreen({super.key});

  @override
  State<MatchedPropertyScreen> createState() => _MatchedPropertyScreenState();
}

class _MatchedPropertyScreenState extends State<MatchedPropertyScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.06,
          right: screenWidth * 0.06,
          top: 20,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              leading: Container(),
              titleSpacing: 0,
              leadingWidth: 0,
              title: CustomSearchBar(
                searchController: searchController,
                screenContext: context,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  S.of(context).searchResults,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) => Text(index.toString()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
